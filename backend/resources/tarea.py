from flask_restful import Resource
from flask import request
from model import db, Usuario, Tarea
import random
import string

class Tasks(Resource):
    def post(self):
        header = request.headers["authorization"]
        json_data = request.get_json(force=True)

        if not header:
            return { "Message": "No API key!"}, 400

        else:
            user = Usuario.query.filter_by(api_key=header).first()

            if user:
                task = Tarea(
                    user_id = user.id,
                    title = json_data["title"],
                    note = json_data["note"], 
                    completed = json_data["completed"],
                    repeats = json_data["repeats"],
                    deadline = json_data["deadline"], 
                    reminder = json_data["reminder"],
                )

                db.session.add(task)
                db.session.commit()

                result = Tarea.serialize(task)

                return { "status": 'success', 'data': result }, 201

            else:
                return { "Message": "No user with that key"}, 400

    def get(self):
        result = []
        header = request.headers["authorization"]

        if not header:
            return { "Message": "No API key!"}, 400

        else:
            user = Usuario.query.filter_by(api_key=header).first()

            if user:
                tasks = Tarea.query.filter_by(user_id=user.id).all()

                for task in tasks:
                    result.append(Tarea.serialize(task))
            

            return { "status": 'success', 'data': result }, 201

        
