import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks_app/models/task.dart';

class DatabaseHelper {
  static final _databaseName = 'TaskDatabase.db';
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

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
    final Database db = await instance.database;
    await db.insert('tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //delete from database
  Future<void> deleteTask(int id) async {
    final Database db = await instance.database;

    await db.delete(
      'tasks',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //get from database

  Future<List<Task>> tasks() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    print(maps);
    return List.generate(maps.length, (index) {
      return Task(
        id: maps[index]['id'],
        title: maps[index]['title'],
        description: maps[index]['description'],
        date: maps[index]['date'],
        reminder: maps[index]['date'],
        isChecked: maps[index]['isChecked'] == 1 ? true : false,
        isCompleted: maps[index]['isCompleted'] == 1 ? true : false,
      );
    });
  }

  //update from database

  // Future<void> updateTask(Task task) async {
  //   final Database db = await instance.database;
  //   print(task.isDone);
  //   await db
  //       .update('tasks', task.toMap(), where: "id = ?", whereArgs: [task.id]);
  //   final List<Map<String, dynamic>> maps = await db.query('tasks');
  //   print(maps);
  // }

  //get row count
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM tasks'));
  }
}
