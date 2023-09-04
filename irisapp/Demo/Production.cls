Class Demo.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Demo.Production" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Demo.PEX.FlaskPEXService" Category="" ClassName="Demo.PEX.FlaskPEXService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="CallInterval">10000</Setting>
  </Item>
  <Item Name="Demo.BP.LLMProcess" Category="" ClassName="Demo.BP.LLMProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="RetryInterval">1000</Setting>
  </Item>
  <Item Name="Demo.BP.NLProcess" Category="" ClassName="Demo.BP.NLProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Demo.BO.FollowupFile" Category="" ClassName="Demo.BO.FollowupFile" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
</Production>
}

}
