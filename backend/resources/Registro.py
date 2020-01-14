from flask_restful import Resource
from flask import request
from model import db, Usuario

class Registro(Resource):
    def get(self):
        users = Usuario.query.all()
        user_list = []

        for i in range(0, len(users)):
            user_list.append(users[i].serialize())


        return {"status": str(user_list)}, 200

    def post(self):
        json_data = request.get_json(force=True)

        if not json_data:
               return {'message': 'No input data provided'}, 400

        data, errors = Usuario.load(json_data)

        if errors:
            return errors, 422

        user = Usuario.query.filter_by(username=json_data['username']).first()
        if user:
            return {'message': 'User with the same name already exists'}, 400

        user = Usuario.query.filter_by(emailadress=json_data['emailadress']).first()
        if user:
            return {'message': 'User with the same email already exists'}, 400

        user = Usuario(
            firstname = json_data["firstname"], 
            lastname = json_data["lastname"],
            email = json_data["emailadress"],
            password = json_data["password"], 
            username = json_data["username"]
        )
        db.session.add(user)
        db.session.commit()

        result = Usuario.serialize(user)

        return { "status": 'success', 'data': result }, 201