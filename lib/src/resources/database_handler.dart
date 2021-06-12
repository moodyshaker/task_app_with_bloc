import 'dart:io';
import 'package:flutter_bloc_pattern/src/models/task_item.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  static const String table_name = 'task_table';
  static const String id = '_id';
  static const String title = 'title';
  static const String content = 'content';
  static const String date = 'date';
  static const int version = 1;
  static Database _db;
  static final instance = DatabaseHandler._instance();

  DatabaseHandler._instance();

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDatabase();
    }
    return _db;
  }

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, table_name);
    Database db =
        await openDatabase(path, onCreate: _createDB, version: version);
    return db;
  }

  Future<void> _createDB(Database db, int version) {
    return db.execute(
      """
      CREATE TABLE $table_name(
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $title TEXT NOT NULL,
      $content TEXT NOT NULL,
      $date TEXT NOT NULL)
    """,
    );
  }

  Future<void> insert(TaskItem item) async {
    await _db.insert(
      table_name,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(TaskItem item) async {
    await _db.update(
      table_name,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: "_id = ?",
      whereArgs: [item.id],
    );
  }

  Future<void> deleteAll() async {
    _db.rawDelete('DELETE FROM $table_name');
  }

  Future<void> delete(int id) async {
    await _db.delete(
      table_name,
      where: '_id = ?',
      whereArgs: [id],
    );
  }

  Future<List<TaskItem>> getData() async {
    List<Map<String, dynamic>> data = await _db.query(
      table_name,
    );
    return data.map((map) => TaskItem.fromMap(map)).toList();

  }

  Future<void> closeDB() async {
    await _db.close();
    _db = null;
  }
}
// class ExpensesDatabase {
//   static final ExpensesDatabase instance = ExpensesDatabase._instance();
//   static const String table_name = 'expenses_review';
//   static const String ID = '_id';
//   static const String TITLE = 'title';
//   static const String DATE = 'date';
//   static const String AMOUNT = 'amount';
//   static const String USER_ID = 'user_id';
//   static const int VERSION = 1;
//   static Database _db;

//   ExpensesDatabase._instance();
//
//   Future<Database> get db async {
//     if (_db == null) {
//       _db = await _initDatabase();
//     }
//     return _db;
//   }
//
//   Future<Database> _initDatabase() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = join(directory.path, table_name);
//     Database db =
//     await openDatabase(path, onCreate: _createDB, version: VERSION);
//     return db;
//   }
//
//   Future<void> _createDB(Database db, int version) {
//     db.execute(
//       """
//       CREATE TABLE $table_name(
//       $ID INTEGER PRIMARY KEY AUTOINCREMENT,
//       $TITLE TEXT NOT NULL,
//       $DATE TEXT NOT NULL,
//       $AMOUNT REAL NOT NULL,
//       $USER_ID TEXT NOT NULL)
//     """,
//     );
//   }
//
//   Future<void> insert(TransactionModel item) async {
//     Database database = await db;
//     await database.insert(
//       table_name,
//       item.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   Future<void> update(TransactionModel item) async {
//     Database database = await db;
//     await database.update(
//       table_name,
//       item.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//       where: "_id = ?",
//       whereArgs: [item.id],
//     );
//   }
//
//   Future<void> deleteAll() async {
//     Database database = await db;
//     database.rawDelete('DELETE FROM $table_name');
//   }
//
//   Future<void> delete(TransactionModel item) async {
//     Database database = await db;
//     await database.delete(
//       table_name,
//       where: '_id = ?',
//       whereArgs: [item.id],
//     );
//   }
//
//   Future<List<TransactionModel>> getData(String userId) async {
//     Database database = await db;
//     List<Map<String, dynamic>> data = await database.query(
//       table_name,
//       where: 'user_id = ?',
//       whereArgs: [userId],
//     );
//     List<TransactionModel> models = [];
//     data.forEach((i) => models.add(TransactionModel.fromMap(i)));
//     return models;
//   }
//
//   Future<void> closeDB() async {
//     Database database = await db;
//     await database.close();
//     _db = null;
//   }
// }
