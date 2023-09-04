Class Demo.Msg.NLPRequest Extends Ens.Request
{

Property ID As %String;

Property Message As %String(MAXLEN = 1000);

Storage Default
{
<Data name="NLPRequestDefaultData">
<Subscript>"NLPRequest"</Subscript>
<Value name="1">
<Value>ID</Value>
</Value>
<Value name="2">
<Value>Message</Value>
</Value>
</Data>
<DefaultData>NLPRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
