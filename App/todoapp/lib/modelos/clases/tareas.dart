class Tareas{
  List<Tareas> tasks;
  String note;
  DateTime timeToComplete;
  bool completed;
  String repeats;
  DateTime deadline;
  List<DateTime> reminders;
  int task_id;
  String title;

  Tareas(this.title, this.completed, this.task_id, this.note);

  factory Tareas.fromJson(Map<String, dynamic> parsedJson) {
    return Tareas(
      parsedJson['title'], 
      parsedJson['completed'], 
      parsedJson['task_id'],
      parsedJson['note']
    );
  }
}