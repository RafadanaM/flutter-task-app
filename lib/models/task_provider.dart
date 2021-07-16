import 'package:flutter/foundation.dart';
import 'package:tasks_app/database/db_helper.dart';
import 'package:tasks_app/models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _completedTasks = [];

  List<Task> _incompleteTasks = [];

  int get taskCompletedCount {
    return _completedTasks.length;
  }

  int get taskIncompleteCount {
    return _incompleteTasks.length;
  }

  Future<List<Task>> get tasksIncomplete async {
    final taskList = await DBHelper().getIncompleteTasks();
    _incompleteTasks = [...taskList];
    //_tasks.sort((a, b) => a.date.compareTo(b.date));
    return _incompleteTasks;
  }

  Future<List<Task>> get tasksComplete async {
    final taskList = await DBHelper().getCompletedTasks();
    _completedTasks = [...taskList];
    //_tasks.sort((a, b) => a.date.compareTo(b.date));
    return _completedTasks;
  }

  void addTask(Task task) async {
    _incompleteTasks.add(task);
    _incompleteTasks.sort((a, b) => a.date.compareTo(b.date));
    notifyListeners();
    DBHelper().insertTask(task);
  }

  void ediTask(Task task) {
    print(task.isCompleted);
    _incompleteTasks.removeWhere((element) => element.id == task.id);
    _completedTasks.add(task);
    //_tasks[_tasks.indexWhere((element) => element.id == task.id)] = task;
    notifyListeners();
    DBHelper().completeTask(task);
  }

  void deleteTask(int id) {
    _incompleteTasks.removeWhere((element) => element.id == id);
    _completedTasks.removeWhere((element) => element.id == id);
    notifyListeners();
    DBHelper().deleteTask(id);
  }
}
