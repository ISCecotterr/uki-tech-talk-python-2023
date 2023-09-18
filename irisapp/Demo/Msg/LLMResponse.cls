Class Demo.Msg.LLMResponse Extends Ens.Response
{

Property Message As %String(MAXLEN = "");

Property ID As %String;

Storage Default
{
<Data name="LLMResponseDefaultData">
<Subscript>"LLMResponse"</Subscript>
<Value name="1">
<Value>json</Value>
</Value>
<Value name="2">
<Value>Message</Value>
</Value>
<Value name="3">
<Value>ID</Value>
</Value>
</Data>
<DefaultData>LLMResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
