import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:tasks_app/models/grocery.dart';
import 'package:tasks_app/models/task.dart';

class DBHelper extends ChangeNotifier {
  static final _databaseName = 'TaskDatabase.db';
  static final _databaseVersion = 1;

  DBHelper();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(await getDatabasesPath(), _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: (db, version) => _createDB(db));
  }

  static void _createDB(Database db) {
    db.execute(
      'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'title TEXT, '
      'description TEXT, '
      'date TEXT, '
      'reminder TEXT ,'
      'isChecked INTEGER, '
      'isCompleted INTEGER)',
    );
    db.execute(
      'CREATE TABLE groceries(id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'title TEXT, '
      'isCompleted INTEGER)',
    );
  }

  //helper

  //insert to database
  Future<void> insertTask(Task task) async {
    final Database db = await database;
    await db.insert('tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    notifyListeners();
  }

  //delete from database
  Future<void> deleteTask(int id) async {
    final Database db = await database;

    await db.delete(
      'tasks',
      where: "id = ?",
      whereArgs: [id],
    );
    notifyListeners();
  }

  //get from database

  Future<List<Task>> tasks() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (index) {
      return Task(
        id: maps[index]['id'],
        title: maps[index]['title'],
        description: maps[index]['description'],
        date: DateTime.parse(maps[index]['date']),
        reminder: maps[index]['reminder'] == 'no reminder'
            ? null
            : DateTime.parse(maps[index]['reminder']),
        isChecked: maps[index]['isChecked'] == 1 ? true : false,
        isCompleted: maps[index]['isCompleted'] == 1 ? true : false,
      );
    });
  }

  Future<List<Task>> getIncompleteTasks() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: "isCompleted = ?",
      whereArgs: [0],
    );
    return List.generate(maps.length, (index) {
      return Task(
        id: maps[index]['id'],
        title: maps[index]['title'],
        description: maps[index]['description'],
        date: DateTime.parse(maps[index]['date']),
        reminder: maps[index]['reminder'] == 'no reminder'
            ? null
            : DateTime.parse(maps[index]['reminder']),
        isChecked: maps[index]['isChecked'] == 1 ? true : false,
        isCompleted: maps[index]['isCompleted'] == 1 ? true : false,
      );
    });
  }

  Future<List<Task>> getCompletedTasks() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: "isCompleted = ?",
      whereArgs: [1],
    );
    return List.generate(maps.length, (index) {
      return Task(
        id: maps[index]['id'],
        title: maps[index]['title'],
        description: maps[index]['description'],
        date: DateTime.parse(maps[index]['date']),
        reminder: maps[index]['reminder'] == 'no reminder'
            ? null
            : DateTime.parse(maps[index]['reminder']),
        isChecked: maps[index]['isChecked'] == 1 ? true : false,
        isCompleted: maps[index]['isCompleted'] == 1 ? true : false,
      );
    });
  }

  //change complete task
  Future<void> completeTask(Task task) async {
    final Database db = await database;
    task.toggleChecked();
    await db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
    notifyListeners();
    Timer(Duration(milliseconds: 750), () async {
      task.toggleCompleted();
      await db
          .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
      notifyListeners();
    });

    final List<Map<String, dynamic>> maps = await db.query('tasks');
  }

  Future<void> updateTask(Task task) async {
    final Database db = await database;
    await db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
    notifyListeners();
    final List<Map<String, dynamic>> maps = await db.query('tasks');
  }

  //get row count
  Future<int> queryRowCount() async {
    Database db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM tasks'));
  }

  // Groceries

  //insert to database
  Future<void> insertGrocery(Grocery grocery) async {
    final Database db = await database;
    await db.insert('groceries', grocery.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    notifyListeners();
  }

  Future<void> completeGrocery(Grocery grocery) async {
    final Database db = await database;
    grocery.toggleCompleted();
    await db.update('groceries', grocery.toMap(),
        where: 'id = ?', whereArgs: [grocery.id]);
    notifyListeners();
  }

  //delete from database
  Future<void> deleteGrocery(int id) async {
    final Database db = await database;

    await db.delete(
      'groceries',
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<void> deleteAllGrocery() async {
    final Database db = await database;

    await db.delete(
      'groceries',
    );
    notifyListeners();
  }

  Future<void> deleteCompletedGrocery(bool isCompleted) async {
    final Database db = await database;

    await db.delete(
      'groceries',
      where: 'isCompleted = ?',
      whereArgs: [isCompleted ? 1 : 0],
    );
    notifyListeners();
  }

  Future<void> uncheckAllGroceries() async {
    final Database db = await database;

    await db.update(
      'groceries', 
      {'isCompleted': 0}
    );
    notifyListeners();
  }

  //get from database
  Future<List<Grocery>> groceries() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('groceries');
    return List.generate(maps.length, (index) {
      return Grocery(
        id: maps[index]['id'],
        title: maps[index]['title'],
        isCompleted: maps[index]['isCompleted'] == 1 ? true : false,
      );
    });
  }
}
