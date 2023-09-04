Class Demo.Msg.FileRequest Extends Ens.Request
{

Property ID As %String;

Property NLPResult As %Boolean;

Property LLMResult As %String(MAXLEN = 1000);

Storage Default
{
<Data name="FileRequestDefaultData">
<Subscript>"FileRequest"</Subscript>
<Value name="1">
<Value>ID</Value>
</Value>
<Value name="2">
<Value>NLPResult</Value>
</Value>
<Value name="3">
<Value>LLMResult</Value>
</Value>
</Data>
<DefaultData>FileRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
