from flask import Blueprint
from flask_restful import Api
from resources.Registro import Registro
from resources.signin import SignIn
from resources.tarea import Tasks

api_bp = Blueprint('api', __name__)
api = Api(api_bp)

api.add_resource(Registro, '/register')
api.add_resource(SignIn, '/signin')
api.add_resource(Tasks, '/tasks')