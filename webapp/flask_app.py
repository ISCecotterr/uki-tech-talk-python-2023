from flask import Flask, jsonify, request
import sys, os, atexit
import iris
import iris.pex

# Initialise Flask app
app = Flask(__name__)

# Define IRIS connection arguments from environment variables defined in docker-compose.yml
hostname = os.environ['IRIS_HOST']
port = int(os.environ['IRIS_PORT'])
namespace = os.environ['IRIS_NAMESPACE']
username = os.environ['IRIS_USERNAME']
password = os.environ['IRIS_PASSWORD']

# Instantiate these objects when __name__ == '__main__'
conn: iris.IRISConnection
pexserv: iris.pex._BusinessService

@app.route('/test/', methods=['GET'])
def get_test():
    iris_status = "OK"
    flask_status = "OK"
    try:
        test_conn = iris.connect(hostname, port, namespace, username, password)
        test_conn.close()
    except Exception as ex:
        iris_status = str(ex)
    return jsonify({'Flask':flask_status, 'IRIS':iris_status})

# POST
# Persists new record over Native API, then initiates PEX Business Service with the record ID.
@app.route('/person/', methods=['POST'])
def post_person():
    #
    # Step 0: Connect to IRIS over native API:
    IRIS = iris.createIRIS(conn)
    #
    # Step 1: Persist the data from the POST payload.
    json_list = request.get_json()
    patient_id = json_list[0]['Patient']
    for item in json_list:
        key_list = item.keys()
        iris_record = IRIS.classMethodObject(className="Demo.Data.Observations", methodName="%New") # Instantiate IRIS inverse-proxy object to create object on IRIS DB.
        for key in key_list:
            value = item[key]
            iris_record.set(key, value) # Iterate through json key-value pairs, assigning values to IRIS object properties with property == key.
        iris_record.invoke("%Save", iris_record)
        record_id = iris_record.invoke("%Id") # Get row ID for saved object from IRIS DB
        iris_record.close()
    #
    # Step 2: Submit messages over PEX Business Service (pexserv).
    print('\n\n' + "POST " + str(patient_id) + '\n\n')
    response = pexserv.ProcessInput(patient_id)
    IRIS.close()
    return response

# GET
# Verifies the ID exists in the IRIS DB over the DB-API, then initiates PEX Business Service.
@app.route('/person/<patient_id>/', methods=['GET'])
def get_person(patient_id: str):
    #
    # Step 0: Connect to IRIS over native API:
    IRIS = iris.createIRIS(conn)
    #
    # Step 1: Verify records exist via DB-API (using the same IRIS connection object):
    cursor = conn.cursor()
    cursor.execute(f"SELECT COUNT(*) FROM Demo_Data.Observations WHERE Patient = '{patient_id}'")
    record = cursor.fetchone()
    if record[0] == [0]:
        return jsonify({'Error':'Patient ID not found.'})
    cursor.close()
    #
    # Step 2: Submit messages over PEX Business Service (pexserv).
    print('\n\n' + "GET " + str(patient_id) + '\n\n')
    response = pexserv.ProcessInput(patient_id)
    IRIS.close()
    return response

# PUT
# Updates the record (if it exists) over the Native API, then initiates the PEX Business Service.
@app.route('/person/<patient_id>/<encounter_id>', methods=['PUT'])
def update_person(patient_id: str, encounter_id: str):
    #
    # Step 0: Connect to IRIS over native API:
    IRIS = iris.createIRIS(conn)
    #
    # Step 1: Verify records exist for this Patient and Encounter
    cursor = conn.cursor()
    cursor.execute(f"SELECT COUNT(*) FROM Demo_Data.Observations WHERE Patient = '{patient_id}' AND Encounter = '{encounter_id}")
    record = cursor.fetchone()
    if record[0] == [0]:
        return jsonify({'Error':'Patient ID and/or Encounter ID not found'})
    cursor.close()
    #
    # Step 2: Update the persistent records with data from the PUT payload.
    json_list = request.get_json()
    for item in json_list:
        try:
            cursor = conn.cursor() # Use cursor object to run queries over DB API
            cursor.execute(f"SELECT ID FROM Demo_Data.Observations WHERE Patient = '{patient_id}' AND Encounter = '{encounter_id}' AND Description = '{item['Description']}")
            record = cursor.fetchone()
            record_id = record.ID
            cursor.close()
            iris_record = IRIS.classMethodObject("Demo.Data.Observations","%OpenId",record_id) # Instantiate IRIS inverse-proxy object via Native API to create object on IRIS DB.
            key_list = item.keys()
            for key in key_list:
                value = item[key]
                iris_record.set(key, value) # Iterate through json key-value pairs, assigning values to IRIS object properties with property == key.
            iris_record.invoke("%Save", iris_record)
            iris_record.close()
        except Exception as ex:
            print(ex)
            pass
    #
    # Step 3: Submit messages over PEX Business Service (pexserv).
    print('\n\n' + "PUT " + str(patient_id) + '\n\n')
    response = pexserv.ProcessInput(patient_id)
    IRIS.close()
    return response

# DELETE
# Verifies the ID exists, then deletes the persistent object from IRIS over the Native API.
@app.route('/person/<patient_id>/<encounter_id>', methods=['DELETE'])
def delete_person(patient_id: str, encounter_id: str):
    #
    # Step 0: Connect to IRIS over native API:
    IRIS = iris.createIRIS(conn)
    #
    # Step 1: Verify records already exist in the IRIS DB
    cursor = conn.cursor()
    cursor.execute(f"SELECT COUNT(*) FROM Demo_Data.Observations WHERE Patient = '{patient_id}' AND Encounter = '{encounter_id}'")
    result = cursor.fetchone()
    if result[0] == [0]:
        return jsonify({'error':'Patient ID and/or Encounter ID not found.'})
    cursor.close()
    #
    # Step 2: Delete record over DB-API:
    cursor = conn.cursor()
    cursor.execute(f"DELETE FROM Demo_Data.Observations WHERE Patient = '{patient_id}' AND Encounter = '{encounter_id}'")
    IRIS.close()
    return jsonify({"Message":"Record deleted successfully."})

def create_business_service(connection, target):
    irisInstance = iris.IRIS(connection)
    irisobject = irisInstance.classMethodObject("EnsLib.PEX.Director","dispatchCreateBusinessService",target)
    service = iris.pex._IRISBusinessService.__new__(iris.pex._IRISBusinessService)
    service.__init__()
    service.irisHandle = irisobject
    return service

# This function is registered by atexit.register() to run when user quits Flask app.
# Note: sys.exit() will not call this even after being registered.
def shutdown():
    try:
        conn.close()
    except Exception:
        pass

if __name__ == '__main__':
    try: # Connect to IRIS
        conn = iris.connect(hostname, port, namespace, username, password)
        atexit.register(shutdown) # Register shutdown method to close IRIS connection on termination.
    except Exception as ex:
        print("Connection to IRIS failed: " + str(ex))
        sys.exit()
    try: # Instantiate Business Service (creates a new Job on IRIS)
        pexserv = create_business_service(conn, "Demo.PEX.FlaskPEXService")
    except Exception as ex:
        conn.close()
        print("PEX Error! Have you started your production? " + str(ex))
        sys.exit()
    try: # Start Flask app
        app.run(host='0.0.0.0', port=8080)
    except Exception as ex:
        conn.close()
        print("Flask app failed: " + str(ex))
        sys.exit()
        
