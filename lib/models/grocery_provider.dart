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

  void addGrocery(Grocery grocery) {
    _groceries.add(grocery);
    notifyListeners();
    DBHelper().insertGrocery(grocery);
  }

  void deleteAllGroceries() {
    _groceries = [];

    notifyListeners();
    DBHelper().deleteAllGrocery();
  }

  void deleteAllCompletedGroceries() {
    _groceries.removeWhere((grocery) => grocery.isCompleted == true);
    notifyListeners();
    DBHelper().deleteCompletedGrocery(true);
  }

  void uncheckAllGroceries() {
    List<Grocery> updatedGroceries = _groceries.map((grocery) {
      grocery.isCompleted = false;
      return grocery;
    }).toList();
    print(updatedGroceries);
    _groceries = [...updatedGroceries];
    notifyListeners();
    DBHelper().uncheckAllGroceries();
  }

  void completeGrocery(Grocery grocery) {
    grocery.toggleCompleted();
    _groceries[_groceries.indexWhere((element) => element.id == grocery.id)] =
        grocery;
    notifyListeners();
    DBHelper().completeGrocery(grocery);
  }

  void updateTask(Task task) {
    task.toggleCompleted();
    notifyListeners();
  }
}
