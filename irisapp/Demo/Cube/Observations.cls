/// 
Class Demo.Cube.Observations Extends %DeepSee.CubeDefinition [ DependsOn = Demo.Data.Observations, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="Observations" displayName="Observations" disabled="false" abstract="false" sourceClass="Demo.Data.Observations" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="DescriptionD" disabled="false" hasAll="false" allCaption="All Description" allDisplayName="Description" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Description" disabled="false" sourceProperty="Description" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="2">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="DateD" disabled="false" hasAll="false" allCaption="All DateD" allDisplayName="DateD" sourceProperty="Date" type="time" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="year" disabled="false" timeFunction="Year" list="false" useDisplayValue="true" sort="desc numeric" useAsFilter="true" hidden="false" factNumber="4">
      </level>
      <level name="month" disabled="false" timeFunction="MonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
      <level name="day" disabled="false" timeFunction="DayMonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
    </hierarchy>
  </dimension>
  <measure name="Value" disabled="false" sourceProperty="Value" aggregate="COUNT" type="string" hidden="false" searchable="false" factNumber="1">
  </measure>
  <measure name="AVG Value" disabled="false" sourceProperty="Value" aggregate="AVG" type="number" hidden="false" searchable="false" factNumber="2">
  </measure>
</cube>
}

Parameter DOMAIN;

}
