import 'package:todoapp/modelos/clases/tareas.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todoapp/modelos/clases/usuario.dart';

class UserBloc {
  final _repository = Repository();
  final _userGetter = PublishSubject<Usuario>();

  Observable<Usuario> get getUser => _userGetter.stream;

  registerUser(String username, String firstname, String lastname, String password, String emailadress) async {
    Usuario user = await _repository.registerUser(username, firstname, lastname, password, emailadress);
    _userGetter.sink.add(user);
  }

  signInUser(String username, String password, String apiKey) async {
    Usuario user = await _repository.signInUser(username, password, apiKey);
    _userGetter.sink.add(user);
  }

  dispose() {
    _userGetter.close();
  }
}

class TaskBloc{
  final _repository = Repository();
  final _taskSubject = BehaviorSubject<List<Tareas>>();
  String apiKey;

  var _tasks = <Tareas>[];

  TaskBloc(String apiKey){
    this.apiKey = apiKey;
    _updateTasks(apiKey).then((_){
      _taskSubject.add(_tasks);
    });
  }

  Stream<List<Tareas>> get getTareas => _taskSubject.stream;


   Future<Null> _updateTasks(String apiKey) async {
     _tasks = await _repository.getUserTasks(apiKey);
  }
}

final bloc = UserBloc();