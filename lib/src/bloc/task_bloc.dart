import 'dart:async';

import 'package:flutter_bloc_pattern/src/models/task_model.dart';
import 'package:flutter_bloc_pattern/src/resources/database_handler.dart';
import 'package:flutter_bloc_pattern/src/resources/task_repository.dart';

import 'bloc.dart';

class TaskBloc implements Bloc {
  final taskRepository = TaskRepository();
  static final TaskBloc instance = TaskBloc._instance();
  final _taskController = StreamController<List<Task>>();

  TaskBloc._instance();

  Stream<List<Task>> get taskController => _taskController.stream;

  void fetchAllTasks() async {
    await taskRepository.db();
    List<Task> tasks = await taskRepository.getAllTasks();
    _taskController.sink.add(tasks);
  }

  void addNewTask(Task item) async {
    await taskRepository.db();
    await taskRepository.addTask(item);
    fetchAllTasks();
  }

  void updateTask(Task item) async {
    await taskRepository.db();
    await taskRepository.updateTask(item);
    fetchAllTasks();
  }

  void deleteTask(int id) async {
    await taskRepository.db();
    await taskRepository.deleteTask(id);
    fetchAllTasks();
  }

  void deleteAll() async {
    await taskRepository.db();
    await taskRepository.deleteAll();
    fetchAllTasks();
  }

  @override
  void dispose() {
    taskRepository.closeDb();
    _taskController.close();
  }
}
