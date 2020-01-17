import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/UI/login/pantallaLogin.dart';
import 'package:todoapp/UI/notas/notas_view.dart';
import 'modelos/global.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/modelos/clases/usuario.dart';
import 'package:todoapp/bloc/blocs/user_bloc_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      theme: ThemeData(
        
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: signInUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          String apiKey = "";

          if (snapshot.hasData){
            apiKey = snapshot.data;
          }

          else{
            print("No data");
          }
          // apiKey.length > 0 ? getHomePage() : LoginPage();
          return apiKey.length > 0 ? getHomePage() : LoginPage(login: login, newUser: false,);
        },
        );
  }

  void login(){
    setState(() {
      build(context);
    });
  }

  Future signInUser() async{
    String username = "";
    String apiKey = await getApiKey();

    if (apiKey.length > 0){
      bloc.signInUser("", "", apiKey);
    }

    else{
      print("No API key");
    }
    return apiKey;
    
  }

  Future getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getString("API_Token");
  }

  Widget getHomePage() {
    return MaterialApp(
        color: Colors.yellow,
        home: SafeArea(
          child: new DefaultTabController(
          length: 3,
          child: new Scaffold(
            body: Stack(
              children: <Widget>[
               TabBarView(
                  children: [
                    NotasView(),
                    new Container(
                      color: Colors.orange,
                      ),
                    new Container(
                      child: Center(
                        child: FlatButton(
                          color: rojo,
                          child: Text("Logout"),
                          onPressed: (){
                            logout();
                          },
                        ),
                      ),
                      color: Colors.lightGreen,
                    ),
                  ],
              ),
              Container(
                padding: EdgeInsets.only(left: 50),
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Notes", style: tituloIntray,),
                    Container()
                  ],
                ),
              ),
              Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.only(top: 120, left: MediaQuery.of(context).size.width*0.5 - 40),
                child: FloatingActionButton(
                  child: Icon(Icons.add, size: 60,),
                  backgroundColor: rojo,
                  onPressed: (){},
                  ),
              )
              ]
            ),
            appBar: AppBar(
              elevation: 0,
              title: new TabBar(
                tabs: [
                  Tab(
                    icon: new Icon(Icons.home),
                  ),
                  Tab(
                    icon: new Icon(Icons.rss_feed),
                  ),
                  Tab(
                    icon: new Icon(Icons.perm_identity),
                  ),
                ],
                labelColor: grisOscuro,
                unselectedLabelColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
              ),
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
          ),
        )
      )
    );
  }

  logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("API_Token", "");

    setState(() {
      build(context);
    });
  }
  @override
  void initState(){
    super.initState();
  }
}
