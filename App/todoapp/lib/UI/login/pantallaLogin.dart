import 'package:flutter/material.dart';
import 'package:todoapp/bloc/blocs/user_bloc_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/modelos/clases/usuario.dart';
import 'package:todoapp/modelos/global.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback login;
  final bool newUser;

  const LoginPage({Key key, this.login, this.newUser,}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grisOscuro,
      body: Center(
        child: widget.newUser ? getSignUpPage() : getSignInPage(),
      ),
    );
  }

  Widget getSignInPage(){
    TextEditingController userText = new TextEditingController();
    TextEditingController passText = new TextEditingController();
    return Container(
      margin: EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Welcome!", style: tituloBienvenida,),
          Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
            Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.transparent),
              child: TextField(
                controller: userText,
                autofocus: false,
                style: TextStyle(fontSize: 22.0, color: grisOscuro),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Username',
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
              ),
            ),
          Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.transparent),
              child: TextField(
                controller: passText,
                autofocus: false,
                style: TextStyle(fontSize: 22.0, color: grisOscuro),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Password',
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
              ),
            ),
          FlatButton(
            child: Text("Sign in", style: tituloRojoNotas,),
            onPressed: (){
                if (userText.text != null || passText.text != null){
                  bloc.signInUser(userText.text, passText.text, "").then((_) {
                    widget.login();
                  });
                }
            },
          )
              ],
            ),
          ),
        
          Container(
            child: Column(
              children: <Widget>[
                Text("Don't you have an account yet?", style: textoRojo, textAlign: TextAlign.center,),
                FlatButton(
                  child: Text("Create account", style: textoRojoBoldNotas,),
                  onPressed: (){
                    if (userText.text != null || passText.text != null){
                      widget.login();
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getSignUpPage(){
    return Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "E-mail"
                ),
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Username"
                ),
              ),
              TextField(
                controller: firstnameController,
                decoration: InputDecoration(
                  hintText: "First name"
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Password"
                ),
              ),
              FlatButton(
                color: Colors.red,
                child: Text("Sign up"),
                onPressed: () {
                  if (usernameController.text != null || passwordController.text != null || emailController.text != null){
                        bloc.registerUser(
                          usernameController.text, 
                          firstnameController.text ?? "", 
                          "", 
                          passwordController.text, 
                          emailController.text).then((_) {
                            widget.login();
                          });
                  }
                },
              )
            ],
          ),
        );
  }
}