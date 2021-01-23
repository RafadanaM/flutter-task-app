import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
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
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, date TEXT, reminder TEXT ,isChecked INTEGER, isCompleted INTEGER)",
      );
    });
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
    print(maps);
    return List.generate(maps.length, (index) {
      return Task(
        id: maps[index]['id'],
        title: maps[index]['title'],
        description: maps[index]['description'],
        date: DateTime.parse(maps[index]['date']),
        reminder: maps[index]['date'] == "no reminder"
            ? null
            : DateTime.parse(maps[index]['date']),
        isChecked: maps[index]['isChecked'] == 1 ? true : false,
        isCompleted: maps[index]['isCompleted'] == 1 ? true : false,
      );
    });
  }

  //update from database

  Future<void> completeTask(Task task) async {
    final Database db = await database;
    task.toggleChecked();
    await db
        .update('tasks', task.toMap(), where: "id = ?", whereArgs: [task.id]);
    notifyListeners();
    Timer(Duration(milliseconds: 750), () async {
      task.toggleCompleted();
      await db
          .update('tasks', task.toMap(), where: "id = ?", whereArgs: [task.id]);
      notifyListeners();
    });

    final List<Map<String, dynamic>> maps = await db.query('tasks');
    print(maps);
  }

  //get row count
  Future<int> queryRowCount() async {
    Database db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM tasks'));
  }
}
