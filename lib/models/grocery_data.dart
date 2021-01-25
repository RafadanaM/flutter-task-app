import 'package:flutter/cupertino.dart';
import 'package:tasks_app/models/grocery.dart';
import 'package:tasks_app/models/task.dart';

class GroceryData extends ChangeNotifier {
  List<Grocery> _groceries = [
    Grocery(
      title: "new Title",
    ),
  ];

  List<Grocery> get groceries {
    return _groceries;
  }

  void updateTask(Task task) {
    task.toggleCompleted();
    notifyListeners();
  }
}
