import 'package:flutter/cupertino.dart';
import 'package:tasks_app/database/db_helper.dart';
import 'package:tasks_app/models/grocery.dart';
import 'package:tasks_app/models/task.dart';

class GroceryProvider extends ChangeNotifier {
  List<Grocery> _groceries = [];

  int get groceriesCount {
    return _groceries.length;
  }

  Future<List<Grocery>> get groceries async {
    final groceries = await DBHelper().groceries();
    _groceries = [...groceries];
    return _groceries;
  }

  void updateTask(Task task) {
    task.toggleCompleted();
    notifyListeners();
  }
}
