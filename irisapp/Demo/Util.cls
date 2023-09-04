Class Demo.Util [ Abstract ]
{

ClassMethod Reset() As %Status
{
    &sql(DELETE FROM Demo_Data.Observations WHERE Patient %STARTSWITH 'Demo')
    return $$$OK
}

}
