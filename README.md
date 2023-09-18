## uki-2023-python-development
Source code for the September 2023 InterSystems UKI Tech Talk on Developing on InterSystems IRIS with Python.


## Deploy with Docker
This is a containerised build of the Tech Talk demo. Running the image will start two containers defined by Dockerfile.IRIS and Dockerfile.Flask for the IRIS and Flask servers respectively.

1. Clone this directory locally with git or zip download.

    ```git clone https://github.com/ecotterr/uki-tech-talk-python-2023.git```

2. Build the image. This may take several minutes due to large python installations of Tensorflow, as well as pulling the IRIS base image.

    ```docker-compose build```

3. Start the containers.

    ```docker-compose up```

    I do not recommend detaching the output so that any issues flagged by the Flask server can be viewed easily.

4. Set your OpenAI API key. API details can be found here: https://platform.openai.com/

    Attach a shell to the IRIS container. You can either click "Attach Shell" via the VSCode Docker Extension, or run:

    ```docker exec -it <container-id> sh```

    Then enter an IRIS shell:

    ```irissession IRIS```

    Then set the key global to your OpenAI API key value:

    ```zn "uki-python-dev" set ^openai.key = "ABC-321"```

    You can exit the iris shell with ```halt```, and exit the container shell with ```exit```

5. Import the Postman collection to your Postman install. Try running the POST request to localhost:8080.

    The first POST may take over a minute. This is because Transformers will cache the Sentiment Analysis model on the IRIS container. Subsequent requests will be much faster. Alternatively, you can set up an Inference Endpoint with Hugging Face and use the Python Requests library to avoid cache, rather than using a Transformers pipeline.


## Repository Contents
Demo source code is split into three directories: 

* irisapp : ObjectScript code to be compiled directly on IRIS server. This includes embedded Python methods, Interoperability Production definitions and the sample data model.
* webapp : Sources for Flask Server, and the Python PEX components to be registered by the IRIS Python External Server.
* cubeapp : One runnable script to generate a matplotlib graph from an IRIS query over DB API.

Docker-specific files are: Dockerfile, docker-compose.yml, iris.script, irisapp/Installer.cls


## Port Forwarding
localhost:8080 -> flask:8080 (Flask Server)

localhost:52781 -> iris:52773 (IRIS WebServer)

localhost:51781 -> iris:1972 (IRIS SuperServer)

Access Management Portal: http://localhost:52781/csp/sys/UtilHome.csp