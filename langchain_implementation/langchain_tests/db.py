from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Calls(db.Model):
    """
    Calls model
    """

    __tablename__ = "calls"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    userInput = db.Column(db.String, nullable=False)
    response = db.Column(db.String,nullable=False)



    def __init__(self, **kwargs): 
        """
        Initializes a Calls object
        """

        self.userInput = kwargs.get("userInput", "") 
        self.response = kwargs.get("response", "") 
    
    def serialize(self):
        """
        Serializes a Calls object
        """

        return {
            "id": self.id,
            "userInput": self.userInput,
            "response": self.response
        }

