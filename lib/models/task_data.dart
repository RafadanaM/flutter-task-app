import 'package:flutter/cupertino.dart';
import 'package:tasks_app/models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [Task(title: "new Title")];

  int get taskCount {
    return _tasks.length;
  }

  List<Task> get tasks {
    return _tasks;
  }
}
