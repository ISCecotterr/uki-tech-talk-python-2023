Class Demo.BP.LLMProcess Extends (Ens.BusinessProcess, %JSON.Adaptor)
{

Method OnRequest(pRequest As EnsLib.PEX.Message, Output pResponse As EnsLib.PEX.Message) As %Status
{
    do ##class(%DeepSee.Utils).%SynchronizeCube("Demo.Cube.Observations",0)
    set json = {}.%FromJSON(pRequest.%json) // Deserialising JSON string to Dynamic Object
    set patientid = json.id
    #;
    set obj = ##class(%DynamicObject).%New()
    set obj.ID = patientid 
    #;
    if patientid '= "" {
        $$$TRACE("[IRIS] LLMProcess:GPT35Process(" _ patientid _ ")")
        set obj.Message = ..GPT35Process(patientid)
        #;
        set NLPReq = ##class(Demo.Msg.NLPRequest).%New()
        set NLPReq.ID = patientid
        set NLPReq.Message = obj.Message
        do ..SendRequestAsync("Demo.BP.NLProcess",NLPReq)        
    }
    else {
        set obj.Message = "System call. Default message."
    }
    set str = obj.%ToJSON()
    #;
    $$$TRACE(str)
    set pex = ##class(EnsLib.PEX.Message).%New()
    set pex.%classname = "FlaskPEXService"
    set pex.%jsonObject = ##class(%DynamicAbstractObject).%FromJSON(str)
    set pResponse = pex
    return $$$OK
}

/// This method uses the OpenAI API for GPT3.5 Turbo. Store your access key in ^openai.key global.
ClassMethod GPT35Process(patientid As %String) As %String [ Language = python ]
{
    import iris
    import openai

    key_glob = iris.gref("^openai.key")
    openai.api_key = key_glob.get([])

    rs = iris.sql.exec(f"SELECT TOP 10 DateF, Code, Description, Value, Units, Type FROM Demo_Data.Observations WHERE Patient = '{patientid}' ORDER BY ID DESC")
    
    content = "In a maximum of 100 words, please give advice for this recent patient assuming they do not have medical knowledge. Do not include disclaimers about being a Large Language Model. Provide urgent advice based on their measurements, especially if they are at risk."
    for idx, row in enumerate(rs):
        text = ' Description: ' + str(row[3]) + ', with the value: ' + str(row[4]) + ' ' + str(row[5]) + '.'
        content += text

    chatgpt_response = openai.ChatCompletion.create(model="gpt-3.5-turbo-16k-0613", messages=[{"role":"user", "content": content}])
    return str(chatgpt_response['choices'][0]['message']['content']).strip()
}

Method OnResponse(request As Ens.Request, ByRef response As Ens.Response, callrequest As Ens.Request, callresponse As Ens.Response, pCompletionKey As %String) As %Status
{
    return $$$OK
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
