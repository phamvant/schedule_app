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
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

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
            isDone INTEGER
          )
        ''');
      },
    );
  }

  Future<void> setup() async {
    print("object");
    await databaseFactory.deleteDatabase('task.db');
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
            'isDone': isDone as int
          } in taskList)
        Task(id, DateTime.parse(assignDate), docNum, company,
            DateTime.parse(dueDate), color, isDone)
    ];

    // Convert the list of each dog's fields into a list of `Dog` objects.
    // return [
    //   for (final {
    //         'id': id as int,
    //         'name': name as String,
    //         'age': age as int,
    //       } in dogMaps)
    //     Dog(id: id, name: name, age: age),
    // ];
  }

  // Add more CRUD operations as needed
}
