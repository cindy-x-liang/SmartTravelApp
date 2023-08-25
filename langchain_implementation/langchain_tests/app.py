import json
from db import db
from flask import Flask, request
from db import Calls
import hotel_flights



app = Flask(__name__)
db_filename = "cms.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()


def success_response(data, code=200):
    return json.dumps(data), code


def failure_response(message, code=404):
    return json.dumps({"error": message}), code



@app.route("/")
@app.route("/api/calls/")
def get_courses():
    """
    Endpoint for getting all tasks
    """

    calls = [call.serialize() for call in Calls.query.all()] 
    return success_response({"calls": calls}) 


@app.route("/api/calls/", methods=["POST"])
def create_course():
    """
    Endpoint for creating a new task
    """
    body = json.loads(request.data)
    new_call = Calls(
        userInput = body.get("userInput"),
        response = hotel_flights.agent().run(body.get("userInput"))
    ) #agent().run(self.userInput) so rhis here
    if not body.get("userInput"):
        return failure_response("No user input",400)
    
    

    db.session.add(new_call) 
    db.session.commit() 
    return success_response(new_call.serialize(), 201)


@app.route("/api/calls/<int:call_id>/")
def get_course(call_id):
    """
    Endpoint for getting a task by id
    """
    call = Calls.query.filter_by(id=call_id).first() 
    if call is None:
        return failure_response("Call not found!") 
    return success_response(call.serialize())


@app.route("/api/calls/<int:call_id>/", methods=["DELETE"])
def delete_course(call_id):
    """
    Endpoint for deleting a task by id
    """
    call = Calls.query.filter_by(id=call_id).first()
    if call is None:
        return failure_response("Call not found!")
    db.session.delete(call)
    db.session.commit()
    return success_response(call.serialize())





if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)