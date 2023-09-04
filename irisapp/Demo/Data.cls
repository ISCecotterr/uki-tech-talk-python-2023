Class Demo.Data Extends %Persistent
{

Property Name As %String [ SqlColumnNumber = 2 ];

Property Number As %Integer [ SqlColumnNumber = 3 ];

Property BoolProp As %Boolean [ SqlColumnNumber = 4 ];

Storage Default
{
<Data name="DataDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Number</Value>
</Value>
<Value name="4">
<Value>BoolProp</Value>
</Value>
</Data>
<DataLocation>^Demo.DataD</DataLocation>
<DefaultData>DataDefaultData</DefaultData>
<IdLocation>^Demo.DataD</IdLocation>
<IndexLocation>^Demo.DataI</IndexLocation>
<StreamLocation>^Demo.DataS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
