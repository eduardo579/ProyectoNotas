import 'package:flutter/material.dart';
import 'package:todoapp/bloc/blocs/user_bloc_provider.dart';
import 'package:todoapp/modelos/clases/tareas.dart';
import 'package:todoapp/modelos/global.dart';
import 'package:todoapp/modelos/widgets/notesTodoWidget.dart';

class NotasView extends StatefulWidget {
  final String apiKey;
  NotasView({this.apiKey});

  @override
  _NotasViewState createState() => _NotasViewState();
}

class _NotasViewState extends State<NotasView> {
  List<Tareas> listaTareas = [];
  TaskBloc tasksBloc;

  @override
  void initState(){
    tasksBloc = TaskBloc(widget.apiKey);
  }

  @override
  void dispose(){
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    return Container(
      color: grisOscuro,
      child: StreamBuilder( // Wrap our widget with a StreamBuilder
        stream: tasksBloc.getTareas, // pass our Stream getter here
        initialData: [], // provide an initial data
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot != null){
            if (snapshot.data.length > 0){
              return _buildReorderableListSimple(context, snapshot.data);
            }

            else if (snapshot.data.length == 0){
              return Center(child: Text("No data"));
            }

            else if (snapshot.hasError){
              return Container();
            }
            return CircularProgressIndicator();
          }
          
        }, // access the data in our Stream here
      )
      /*child: ReorderableListView(
        padding: EdgeInsets.only(top: 300),
        children: todoItems,
        onReorder: _onReorder,
      )*/
    );
  }

  Widget _buildListTitle(BuildContext context, Tareas item){
    return ListTile(
      key: Key(item.task_id.toString()),
      title: NotesTodo(
        titulo: item.title,
      ),
      );
  }

  Widget _buildReorderableListSimple(BuildContext context, List<Tareas> listaTareas){
    return Theme(
          data: ThemeData(
            canvasColor: Colors.transparent
          ),
          child: ReorderableListView(
        padding: EdgeInsets.only(top: 250.0),
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

  // Future<List<Tareas>> getList() async{
  //     List<Tareas> tareas = await tasksBloc.getUserTasks(widget.apiKey);

  //     return tareas;
  // }
}
