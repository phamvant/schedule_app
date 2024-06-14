import 'package:memo/models/task.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'task.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE task(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            assignDate TEXT,
            docNum TEXT,
            company TEXT,
            dueDate TEXT,
            color INTEGER,
            isDone INTEGER,
            doneTime TEXT
          )
        ''');

        await db.insert(
          'task',
          {
            'assignDate': DateTime.now().toString(),
            'docNum': "12345678",
            'company':
                "Đây là ghi chú mẫu. Phần này chứa tên công ty. Mẫu này có hạn 2 ngày",
            'dueDate': DateTime.now().add(const Duration(days: 2)).toString(),
            'color': 0,
            'isDone': 0
          },
        );
        await db.insert(
          'task',
          {
            'assignDate': DateTime.now().toString(),
            'docNum': "87654321",
            'company':
                "Đây là ghi chú mẫu. Phần này chứa tên công ty. Mẫu này có hạn 5 ngày",
            'dueDate': DateTime.now().add(const Duration(days: 5)).toString(),
            'color': 0,
            'isDone': 0
          },
        );
        await db.insert(
          'task',
          {
            'assignDate': DateTime.now().toString(),
            'docNum': "88888888",
            'company':
                "Đây là ghi chú mẫu. Phần này chứa tên công ty. Cột này có hạn > 7 ngày",
            'dueDate': DateTime.now().add(const Duration(days: 20)).toString(),
            'color': 0,
            'isDone': 0
          },
        );
        await db.insert(
          'task',
          {
            'assignDate': DateTime.now().toString(),
            'docNum': "66666666",
            'company':
                "Đây là ghi chú mẫu. Phần này chứa tên công ty. Đây là văn bản đã hoàn thành",
            'dueDate': DateTime.now().add(const Duration(days: 20)).toString(),
            'color': 0,
            'isDone': 1,
            'doneTime': DateTime.now().add(const Duration(days: 20)).toString(),
          },
        );
      },
    );
  }

  Future<void> delete(int id) async {
    final db = await database;
    await db.delete(
      "task",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> insertForm(Map<String, dynamic> form) async {
    Database db = await database;
    return await db.insert('task', form);
  }

  Future<List<Task>> getTasks() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all the dogs.
    final List<Map<String, Object?>> taskList = await db.query('task');

    return [
      for (final {
            'id': id as int,
            'assignDate': assignDate as String,
            'docNum': docNum as String,
            'company': company as String,
            'dueDate': dueDate as String,
            'color': color as int,
            'isDone': isDone as int,
            'doneTime': doneTime as String?
          } in taskList)
        Task(
            id,
            DateTime.parse(assignDate),
            docNum,
            company,
            DateTime.parse(dueDate),
            color,
            isDone,
            doneTime == null ? null : DateTime.parse(doneTime))
    ];
  }

  Future<void> toogleDone(int idx, int val) async {
    final db = await database;
    String? doneTime;
    if (val == 1) {
      doneTime = DateTime.now().toString();
    }

    await db.update("task", {'isDone': val, 'doneTime': doneTime},
        where: 'id = ?', whereArgs: [idx]);
  }

  // Add more CRUD operations as needed
}
