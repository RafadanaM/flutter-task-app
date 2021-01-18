import 'package:flutter/cupertino.dart';
import 'package:tasks_app/models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(
      title: "new Title",
      description: "A description",
      date: DateTime.now().add(Duration(minutes: 30)),
      reminder: DateTime.now(),
    ),
    Task(
      title: "new Title",
      description: "A description",
      date: DateTime.now().add(Duration(minutes: 30)),
      reminder: DateTime.now(),
    ),
    Task(
      title: "new Title",
      description: "A description",
      date: DateTime.now().add(Duration(minutes: 30)),
      reminder: DateTime.now(),
    ),
    Task(
      title: "new Title",
      description: "A description",
      date: DateTime.now().add(Duration(minutes: 30)),
      reminder: DateTime.now(),
    ),
  ];

  int get taskCount {
    return _tasks.length;
  }

  List<Task> get tasks {
    return _tasks;
  }

  void addTask(String title, String description, DateTime date,
      DateTime reminder) async {
    _tasks.add(Task(
        title: title,
        description: description,
        date: date,
        reminder: reminder));
    // await this.db.insertTask(Task(name: taskName));
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleCompleted();
    notifyListeners();
  }
}
