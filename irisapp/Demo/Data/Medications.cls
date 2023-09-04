Class Demo.Data.Medications Extends %Persistent
{

Property Start As %String [ SqlColumnNumber = 2 ];

Property Stop As %String [ SqlColumnNumber = 3 ];

Property Patient As %String [ SqlColumnNumber = 4 ];

Property Payer As %String [ SqlColumnNumber = 5 ];

Property Encounter As %String [ SqlColumnNumber = 6 ];

Property Code As %String [ SqlColumnNumber = 7 ];

Property Description As %String [ SqlColumnNumber = 8 ];

Property BaseCost As %String [ SqlColumnNumber = 9 ];

Property PayerCoverage As %String [ SqlColumnNumber = 10 ];

Property Dispenses As %String [ SqlColumnNumber = 11 ];

Property TotalCost As %String [ SqlColumnNumber = 12 ];

Property ReasonCode As %String [ SqlColumnNumber = 13 ];

Property ReasonDescription As %String [ SqlColumnNumber = 14 ];

Storage Default
{
<Data name="MedicationsDefaultData">
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
<Value>Payer</Value>
</Value>
<Value name="6">
<Value>Encounter</Value>
</Value>
<Value name="7">
<Value>Code</Value>
</Value>
<Value name="8">
<Value>Description</Value>
</Value>
<Value name="9">
<Value>BaseCost</Value>
</Value>
<Value name="10">
<Value>PayerCoverage</Value>
</Value>
<Value name="11">
<Value>Dispenses</Value>
</Value>
<Value name="12">
<Value>TotalCost</Value>
</Value>
<Value name="13">
<Value>ReasonCode</Value>
</Value>
<Value name="14">
<Value>ReasonDescription</Value>
</Value>
</Data>
<DataLocation>^Demo.Data.MedicationsD</DataLocation>
<DefaultData>MedicationsDefaultData</DefaultData>
<IdLocation>^Demo.Data.MedicationsD</IdLocation>
<IndexLocation>^Demo.Data.MedicationsI</IndexLocation>
<StreamLocation>^Demo.Data.MedicationsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
