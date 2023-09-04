Class Demo.Data.Conditions Extends %Persistent
{

Property Start As %String [ SqlColumnNumber = 2 ];

Property Stop As %String [ SqlColumnNumber = 3 ];

Property Patient As %String [ SqlColumnNumber = 4 ];

Property Encounter As %String [ SqlColumnNumber = 5 ];

Property Code As %String [ SqlColumnNumber = 6 ];

Property Description As %String [ SqlColumnNumber = 7 ];

Storage Default
{
<Data name="ConditionsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Start</Value>
</Value>
<Value name="3">
<Value>Stop</Value>
</Value>
<Value name="4">
<Value>Patient</Value>
</Value>
<Value name="5">
<Value>Encounter</Value>
</Value>
<Value name="6">
<Value>Code</Value>
</Value>
<Value name="7">
<Value>Description</Value>
</Value>
</Data>
<DataLocation>^Demo.Data.ConditionsD</DataLocation>
<DefaultData>ConditionsDefaultData</DefaultData>
<IdLocation>^Demo.Data.ConditionsD</IdLocation>
<IndexLocation>^Demo.Data.ConditionsI</IndexLocation>
<StreamLocation>^Demo.Data.ConditionsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
