Class Demo.Data.Observations Extends %Persistent
{

Property Date As %DateTime [ SqlColumnNumber = 2, SqlFieldName = DateF ];

Property Patient As %String [ SqlColumnNumber = 3 ];

Property Encounter As %String [ SqlColumnNumber = 4 ];

Property Code As %String [ SqlColumnNumber = 5 ];

Property Description As %String [ SqlColumnNumber = 6 ];

Property Value As %String [ SqlColumnNumber = 7 ];

Property Units As %String [ SqlColumnNumber = 8 ];

Property Type As %String [ SqlColumnNumber = 9 ];

Index PatientIDX On Patient;

Index ComboIDX On (Patient, Encounter);

Storage Default
{
<Data name="ObservationsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Date</Value>
</Value>
<Value name="3">
<Value>Patient</Value>
</Value>
<Value name="4">
<Value>Encounter</Value>
</Value>
<Value name="5">
<Value>Code</Value>
</Value>
<Value name="6">
<Value>Description</Value>
</Value>
<Value name="7">
<Value>Value</Value>
</Value>
<Value name="8">
<Value>Units</Value>
</Value>
<Value name="9">
<Value>Type</Value>
</Value>
</Data>
<DataLocation>^Demo.Data.ObservationsD</DataLocation>
<DefaultData>ObservationsDefaultData</DefaultData>
<IdLocation>^Demo.Data.ObservationsD</IdLocation>
<IndexLocation>^Demo.Data.ObservationsI</IndexLocation>
<StreamLocation>^Demo.Data.ObservationsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
