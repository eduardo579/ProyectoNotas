from flask import Flask
from marshmallow import Schema, fields, pre_load, validate
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy

ma = Marshmallow()
db = SQLAlchemy()

class Usuario(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.Integer(), primary_key=True)
    api_key = db.Column(db.String())
    firstname = db.Column(db.String())
    lastname = db.Column(db.String())
    password = db.Column(db.String())
    emailadress = db.Column(db.String())
    username = db.Column(db.String(), unique=True)

    def __init__(self, api_key, firstname, lastname, emailadress, password, username):
        self.firstname = firstname
        self.lastname = lastname
        self.emailadress = emailadress
        self.password = password
        self.username = username
        self.api_key = api_key

    def __repr__(self):
        return '<id {}>'.format(self.id)

    def serialize(self):
        return {
            'api_key' : self.api_key,
            'id' : self.id,
            'username' : self.username,
            'firstname' : self.firstname,
            'lastname' : self.lastname,
            'password' : self.password,
            'emailadress' : self.emailadress,
        }


class Tarea(db.Model):
    __tablename__ = 'tasks'

    id = db.Column(db.Integer(), primary_key=True)
    user_id = db.Column(db.Integer(), db.ForeignKey('users.id'))
    note = db.Column(db.String())
    completed = db.Column(db.Boolean(), default=False, nullable=False)
    repeats = db.Column(db.String())
    deadline = db.Column(db.String())
    reminder = db.Column(db.String())

    def __init__(self, user_id, note, completed, repeats, deadline, reminder):
        self.user_id = user_id
        self.deadline = deadline
        self.reminder = reminder
        self.completed = completed
        self.note = note
        self.repeats = repeats
        
    def __repr__(self):
        return '<id {}>'.format(self.id)

    def serialize(self):
        return {
            'user_id' : self.user_id,
            'id' : self.id,
            'repeats' : self.repeats,
            'deadline' : self.deadline,
            'reminder' : self.reminder,
            'completed' : self.completed,
            'note' : self.note,
        }
