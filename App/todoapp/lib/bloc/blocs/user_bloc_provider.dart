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

  signInUser(String username, String password) async {
    Usuario user = await _repository.signInUser(username, password);
    _userGetter.sink.add(user);
  }

  dispose() {
    _userGetter.close();
  }
}

final bloc = UserBloc();