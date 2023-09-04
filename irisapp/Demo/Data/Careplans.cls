Class Demo.Data.Careplans Extends %Persistent
{

Property Start As %String [ SqlColumnNumber = 2 ];

Property Stop As %String [ SqlColumnNumber = 3 ];

Property Patient As %String [ SqlColumnNumber = 4 ];

Property Encounter As %String [ SqlColumnNumber = 5 ];

Property Code As %String [ SqlColumnNumber = 6 ];

Property Description As %String [ SqlColumnNumber = 7 ];

Property ReasonCode As %String [ SqlColumnNumber = 8 ];

Property ReasonDescription As %String [ SqlColumnNumber = 9 ];

Storage Default
{
<Data name="CareplansDefaultData">
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
<Value name="8">
<Value>ReasonCode</Value>
</Value>
<Value name="9">
<Value>ReasonDescription</Value>
</Value>
</Data>
<DataLocation>^Demo.Data.CareplansD</DataLocation>
<DefaultData>CareplansDefaultData</DefaultData>
<IdLocation>^Demo.Data.CareplansD</IdLocation>
<IndexLocation>^Demo.Data.CareplansI</IndexLocation>
<StreamLocation>^Demo.Data.CareplansS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
