import 'package:flutter/cupertino.dart';
import 'package:tasks_app/models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(
        title: "new Title",
        description: "A description",
        date: "6 September 1969"),
    Task(
        title: "new Title2",
        description: "A description",
        date: "6 September 1969"),
    Task(
        title: "new Title3",
        description: "A description",
        date: "6 September 1969"),
  ];

  int get taskCount {
    return _tasks.length;
  }

  List<Task> get tasks {
    return _tasks;
  }

  void updateTask(Task task) {
    task.toggleCompleted();
    notifyListeners();
  }
}
