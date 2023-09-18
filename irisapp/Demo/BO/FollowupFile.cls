Class Demo.BO.FollowupFile Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCATION = "Queue";

XData MessageMap
{
<MapItems>
    <MapItem MessageType="Demo.Msg.FileRequest">
        <Method>WriteMessage</Method>
    </MapItem>
</MapItems>
}

Method WriteMessage(pRequest As Demo.Msg.FileRequest, Output pResponse As Ens.Response) As %Status
{
    set filename = "followups.txt"
   // set ..Adapter.FilePath = "/opt/irisapp/"
    set ..Adapter.FilePath = "C:\SRC\uki-2023-python-development\irisapp\"
    
    set str = pRequest.ID _ "    " _ pRequest.NLPResult _ "    " _ pRequest.LLMResult
    set st = ..Adapter.PutLine(filename, str)
    return $$$OK
}

}
