from flask_restful import Resource
from flask import request
from model import db, Usuario
import random
import string

class SignIn(Resource):
    def post(self):
        result = ""
        json_data = request.get_json(force=True)
        auth = request.authorization

        if not auth:
            result = self.signInUserPass(json_data)

        else:
            user = Usuario.query.filter_by(api_key=json_data['api_key']).first()

            if user:
                result = Usuario.serialize(user)
            
            else:
                result = self.signInUserPass(json_data)

        return { "status": 'success', 'data': result }, 201

    def signInUserPass(self, json_data):
        if not json_data:
            return {'message': 'No input data provided'}, 400

        user = Usuario.query.filter_by(username=json_data['username']).first()
        if not user:
            return {'message': 'User does not exist'}, 400

        if user.password != json_data['password']:
            return {'message': 'Password incorrect'}, 400

        return Usuario.serialize(user)

    def generate_key(self):
        return ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(50))