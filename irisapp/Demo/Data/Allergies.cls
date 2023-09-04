Class Demo.Data.Allergies Extends %Persistent
{

Property Start As %String [ SqlColumnNumber = 2 ];

Property Stop As %String [ SqlColumnNumber = 3 ];

Property Patient As %String [ SqlColumnNumber = 4 ];

Property Encounter As %String [ SqlColumnNumber = 5 ];

Property Code As %String [ SqlColumnNumber = 6 ];

Property Description As %String [ SqlColumnNumber = 7 ];

Storage Default
{
<Data name="AllergiesDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Patient</Value>
</Value>
<Value name="3">
<Value>Encounter</Value>
</Value>
<Value name="4">
<Value>Code</Value>
</Value>
<Value name="5">
<Value>Description</Value>
</Value>
<Value name="6">
<Value>Start</Value>
</Value>
<Value name="7">
<Value>Stop</Value>
</Value>
</Data>
<DataLocation>^Demo.Data.AllergiesD</DataLocation>
<DefaultData>AllergiesDefaultData</DefaultData>
<IdLocation>^Demo.Data.AllergiesD</IdLocation>
<IndexLocation>^Demo.Data.AllergiesI</IndexLocation>
<StreamLocation>^Demo.Data.AllergiesS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
