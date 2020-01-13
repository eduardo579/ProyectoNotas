from flask_restful import Resource
from flask import request
from model import db, Usuario

class Registro(Resource):
    def get(self):
        users = Usuario.query.all()
        users = users.dump(users).data
        return {"status": "success", "data": users}, 200

    def post(self):
        json_data = request.get_json(force=True)

        if not json_data:
               return {'message': 'No input data provided'}, 400

        data, errors = Usuario.load(json_data)

        if errors:
            return errors, 422

        user = Usuario.query.filter_by(username=json_data['username']).first()
        if user:
            return {'message': 'User already exists'}, 400

        username = data['username']
        password = data['password']
        email = data["email"]

        user = Usuario(
            firstname = json_data["firstname"], 
            lastname = json_data["lastname"],
            email = json_data["emailadress"],
            password = json_data["password"], 
            username = json_data["username"]
        )
        db.session.add(user)
        db.session.commit()

        result = Usuario.dump(user).data

        return { "status": 'success', 'data': result }, 201