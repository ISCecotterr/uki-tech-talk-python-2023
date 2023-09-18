Class Demo.BP.NLProcess Extends Ens.BusinessProcess
{

Method OnRequest(pRequest As Demo.Msg.NLPRequest, Output pResponse As %Persistent) As %Status
{
    set bool = ..HFNLPSentimentAnalysis(pRequest.Message)
    $$$TRACE("Analysis result: " _ bool)
    $$$TRACE(..finalsentence(pRequest.Message))
    if bool = 1 {
        set msg = ##class(Demo.Msg.FileRequest).%New()
        set msg.ID = pRequest.ID
        set msg.NLPResult = 1
        set msg.LLMResult = pRequest.Message
        do ..SendRequestAsync("Demo.BO.FollowupFile", msg)
    }
    return $$$OK
}

ClassMethod finalsentence(pContent As %String) As %String [ Language = python ]
{
    array = pContent.replace("\n","").split(".")
    final_sentence = array[-2]
    return final_sentence
}

/// Uses a Transformers pipeline for inference on a pre-trained model. Model is cached locally after initial pipeline download.
ClassMethod HFNLPSentimentAnalysis(pContent As %String) As %Boolean [ Language = python ]
{
    from transformers import pipeline
    import os

    array = pContent.replace("\n","").split(".")
    final_sentence = array[-2]

    task = pipeline("text-classification", model="cardiffnlp/twitter-roberta-base-sentiment-latest")
    example_str = "Please consult a healthcare professional immediately to assess your condition and discuss appropriate treatment options to mitigate these risks."
    resp = task(final_sentence)

    result_label = resp[0]['label']
    result_score = resp[0]['score']

    if result_label == 'negative' and result_score > 0.5:
        return 1
    return 0
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
