from flask import Blueprint
from flask_restful import Api
from resources.Registro import Registro

api_bp = Blueprint('api', __name__)
api = Api(api_bp)

api.add_resource(Registro, '/register')