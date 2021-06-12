import 'package:flutter_bloc_pattern/src/models/task_item.dart';
import 'package:flutter_bloc_pattern/src/resources/database_handler.dart';
import 'package:sqflite/sqflite.dart';

class TaskRepository {
  DatabaseHandler _databaseHandler = DatabaseHandler.instance;

  Future<Database> db() async => _databaseHandler.db;

  Future<void> addTask(TaskItem item) async => _databaseHandler.insert(item);

  Future<void> deleteTask(int id) async => _databaseHandler.delete(id);

  Future<void> updateTask(TaskItem item) async => _databaseHandler.update(item);

  Future<void> deleteAll() async => _databaseHandler.deleteAll();

  Future<List<TaskItem>> getAllTasks() => _databaseHandler.getData();

  Future<void> closeDb() => _databaseHandler.closeDB();
}
