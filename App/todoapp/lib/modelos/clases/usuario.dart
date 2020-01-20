

class Usuario {
  String username;
  String lastname;
  String firstname;
  String emailadress;
  String password;
  String api_key;
  int id;

  Usuario(this.username, this.lastname, this.firstname, this.emailadress, this.password, this.api_key, this.id);

  factory Usuario.fromJson(Map<String, dynamic> parsedJson) {
    return Usuario(
      parsedJson['username'], 
      parsedJson['lastname'], 
      parsedJson['firstname'], 
      parsedJson['emailadress'], 
      parsedJson['password'],
      parsedJson['id'],
      parsedJson['api_key']
    );
  }
}