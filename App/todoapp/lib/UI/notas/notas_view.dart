import 'package:flutter/material.dart';
import 'package:todoapp/modelos/clases/tareas.dart';
import 'package:todoapp/modelos/global.dart';
import 'package:todoapp/modelos/widgets/notesTodoWidget.dart';

class NotasView extends StatefulWidget {

  @override
  _NotasViewState createState() => _NotasViewState();
}

class _NotasViewState extends State<NotasView> {
  List<Tareas> listaTareas = [];
  @override
  Widget build(BuildContext context) {
    listaTareas = getList();
    return Container(
      color: grisOscuro,
      child: _buildReorderableListSimple(context),
      /*child: ReorderableListView(
        padding: EdgeInsets.only(top: 300),
        children: todoItems,
        onReorder: _onReorder,
      )*/
    );
  }

  Widget _buildListTitle(BuildContext context, Tareas item){
    return ListTile(
      key: Key(item.idTareas),
      title: NotesTodo(
        titulo: item.titulo,
      ),
      );
  }

  Widget _buildReorderableListSimple(BuildContext context){
    return Theme(
          data: ThemeData(
            canvasColor: grisOscuro
          ),
          child: ReorderableListView(
        padding: EdgeInsets.only(top: 30.0),
        children: listaTareas.map((Tareas item) => _buildListTitle(context, item)).toList(),
        onReorder: (oldIndex, newIndex){
          setState(() {
            Tareas item = listaTareas[oldIndex];
            listaTareas.remove(item);
            listaTareas.insert(newIndex, item);
          });
        }
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex){
    setState(() {
      if (newIndex > oldIndex)
      {
        newIndex -= 1;
      }
      final Tareas item = listaTareas.removeAt(oldIndex);
      listaTareas.insert(newIndex, item);
    });
  }

  List<Tareas> getList(){
      for (int i = 0; i < 10; i++){
       listaTareas.add(Tareas("My first todo" + i.toString(), false, i.toString()));
      }

      return listaTareas;
  }
}
