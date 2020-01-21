import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/modelos/clases/tareas.dart';
import 'dart:convert';
import 'package:todoapp/modelos/clases/usuario.dart';

class ApiProvider {
  Client client = Client();
  final _apiKey = 'your_api_key';

  Future<Usuario> registerUser(String username, String firstname, String lastname, String password, String emailadress) async {
    final response = await client
        .post("http://127.0.0.1:5000/api/register",
        //headers: "",
        body: jsonEncode({
          "emailadress": emailadress,
          "username": username,
          "password": password,
          "firstname": firstname,
          "lastname": lastname
        })
        );
        
    final Map result = json.decode(response.body);

    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      await saveApiKey(result["data"]['api_key']);
      return Usuario.fromJson(result["data"]);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future signInUser(String username, String password, String apiKey) async {
    final response = await client
        .post("http://127.0.0.1:5000/api/signin",
        headers: {
          "Authorization": apiKey
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        })
        );
        
    final Map result = json.decode(response.body);

    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      await saveApiKey(result["data"]['api_key']);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<List<Tareas>> getUserTasks(String apiKey) async {
    final response = await client
        .get("http://127.0.0.1:5000/api/tasks",
        headers: {
          "Authorization": apiKey
        },
   
        );
        
    final Map result = json.decode(response.body);

    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      List<Tareas> tareas = [];

      for (Map json_ in result["data"]){
        try{
          tareas.add(Tareas.fromJson(json_));
        }
        catch (Exception){
          print(Exception);
        }
        
      }

      return tareas;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load tasks');
    }
  }

  Future addUserTasks(String apiKey, String taskName, String deadline) async {
    final response = await client
        .post("http://127.0.0.1:5000/api/tasks",
        headers: {
          "Authorization": apiKey
        },
        body: jsonEncode({
          "title": taskName,
          "note": "",
          "repeats": "",
          "completed" : false,
          "deadline": deadline,
          "reminder": ""
        })
   
        );

    if (response.statusCode == 201) {
    print("Task added");
    } 

    else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load tasks');
    }
  }

  saveApiKey(String api_key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('API_Token', api_key);
  }
}