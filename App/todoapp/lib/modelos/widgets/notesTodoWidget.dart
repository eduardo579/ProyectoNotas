import 'package:flutter/material.dart';

import '../global.dart';

class NotesTodo extends StatelessWidget {
  final String titulo;
  final String keyValue;
  NotesTodo({this.keyValue, this.titulo});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      key: Key(keyValue),
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: rojo,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          new BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10.0,
          ),
        ]
      ),
      child: Row(
        children: <Widget>[
          Radio(

          ),
          Column(
            children: <Widget>[
            Text(titulo, style: tituloNotas,),
          ],)
      ],),
    );
  }

}