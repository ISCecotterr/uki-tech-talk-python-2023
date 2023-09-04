import iris
import iris.pex
import json
from flask_pex_message import FlaskPEXMessage
from flask_response import FlaskResponse

class FlaskPEXService(iris.pex.BusinessService):

    # NOTE: This is a 'non-polling' business service, so it does not require an inbound adapter, hence the commenting.
    # def getAdapterType():
        # return "Demo.PEX.FlaskInboundAdapter"
    
    # Init method run from IRIS when PEX Service is started.
    def OnInit(self):
        self.LOGINFO("[Python] FlaskPEXService:OnInit()")
        return
    
    # TearDown method run from IRIS when PEX Service is stopped.
    def OnTearDown(self):
        self.LOGINFO("[Python] FlaskPEXService:OnTearDown()")
        return
    
    # As a non-polling service, invoke this method directly from upstream app using Director.CreateBusinessService(conn,target).ProcessInput(id)
    def OnProcessInput(self, id):
        self.LOGINFO(f"[Python] FlaskPEXService:OnProcessInput(id: {id})")
        request = FlaskPEXMessage(id)
        response = self.SendRequestSync("Demo.BP.LLMProcess", request)
        output = json.dumps({'ID':response.ID, 'Message':response.Message})
        # output = FlaskResponse(response.ID, response.Message)
        return output
    