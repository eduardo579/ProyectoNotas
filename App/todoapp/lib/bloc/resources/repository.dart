import 'dart:async';
import 'package:todoapp/modelos/clases/usuario.dart';
import 'api.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<Usuario> registerUser(String username, String firstname, String lastname, String password, String emailadress) 
  => apiProvider.registerUser(username, firstname, lastname, password, emailadress);

   Future signInUser(String username, String password, String apiKey) 
  => apiProvider.signInUser(username, password, apiKey);

  Future getUserTasks(String apiKey) 
  => apiProvider.getUserTasks(apiKey);

  Future<Null> addUserTasks(String apiKey, String taskName, String deadline) async{
  	apiProvider.addUserTasks(apiKey, taskName, deadline);
  }
}