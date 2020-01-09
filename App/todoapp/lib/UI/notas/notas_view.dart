import 'package:flutter/material.dart';
import 'package:todoapp/modelos/global.dart';

class NotasView extends StatefulWidget {

  @override
  _NotasViewState createState() => _NotasViewState();
}

class _NotasViewState extends State<NotasView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: grisOscuro,
      child: ListView(
        padding: EdgeInsets.only(top: 300),
        children: getList(),
      ),
    );
  }

  List<Widget> getList(){
    return [
      
    ];
  }
}
