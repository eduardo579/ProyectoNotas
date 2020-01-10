class Tareas{
  List<Tareas> tareas;
  String nota;
  DateTime tiempoACompletar;
  bool completado;
  String repeticiones;
  DateTime deadline;
  List<DateTime> recordatorios;
  String idTareas;
  String titulo;

  Tareas(this.titulo, this.completado, this.idTareas);
}