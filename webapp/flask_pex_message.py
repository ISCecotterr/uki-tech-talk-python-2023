import iris.pex

class FlaskPEXMessage(iris.pex.Message):

    def __init__(self, id):
        super().__init__()
        self.id = id