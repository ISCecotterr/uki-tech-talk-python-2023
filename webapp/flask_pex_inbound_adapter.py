import iris.pex
from flask_pex_message import FlaskPEXMessage

class FlaskPEXInboundAdapter(iris.pex.InboundAdapter):
    
    # When registering this adapter, this is the proxy name we will assign.
    # proxy_name = "Demo.PEX.FlaskInboundAdapter"

    def OnInit(self):
        print(f"[Python] FlaskPEXInboundAdapter:OnInit()")
        #
        return
    
    def OnTearDown(self):
        print("[Python] FlaskPEXInboundAdapter:OnTearDown()")
        #
        return
    
    def OnTask(self) -> str:
        print("[Python] FlaskPEXInboundAdapter:OnTask()")
        request = FlaskPEXMessage # do something to generate a FlaskPEXMessage - i.e. polling an upstream application / service of some kind
        response = self.BusinessHost.ProcessInput(request)
        return response