import 'package:flutter/material.dart';
import 'package:todoapp/modelos/global.dart';
import 'package:todoapp/modelos/widgets/notesTodoWidget.dart';

class NotasView extends StatefulWidget {

  @override
  _NotasViewState createState() => _NotasViewState();
}

class _NotasViewState extends State<NotasView> {
  List<NotesTodo> todoItems = [];
  @override
  Widget build(BuildContext context) {
    todoItems = getList();
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

  Widget _buildListTitle(BuildContext context, NotesTodo item){
    return ListTile(
      key: Key(item.keyValue),
      title: item,
      );
  }

  Widget _buildReorderableListSimple(BuildContext context){
    return ReorderableListView(
      padding: EdgeInsets.only(top: 30.0),
      children: todoItems.map((NotesTodo item) => _buildListTitle(context, item)).toList(),
      onReorder: (oldIndex, newIndex){
        setState(() {
          NotesTodo item = todoItems[oldIndex];
          todoItems.remove(item);
          todoItems.insert(newIndex, item);
        });
      }
    );
  }

  void _onReorder(int oldIndex, int newIndex){
    setState(() {
      if (newIndex > oldIndex)
      {
        newIndex -= 1;
      }
      final NotesTodo item = todoItems.removeAt(oldIndex);
      todoItems.insert(newIndex, item);
    });
  }

  List<Widget> getList(){
      for (int i = 0; i < 10; i++){
       todoItems.add(NotesTodo(keyValue: i.toString(), titulo: "Hello"));
      }

      return todoItems;
  }
}
