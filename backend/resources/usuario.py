from flask_restful import Resource

class Usuario(Resource):
    def get(self):
        return {"message": "Hola mundo!"}
        
