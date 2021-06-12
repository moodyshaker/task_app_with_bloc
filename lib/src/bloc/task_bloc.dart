import 'dart:async';

import 'package:flutter_bloc_pattern/src/models/task_item.dart';
import 'package:flutter_bloc_pattern/src/resources/database_handler.dart';
import 'package:flutter_bloc_pattern/src/resources/task_repository.dart';

import 'bloc.dart';

class TaskBloc implements Bloc {
  final taskRepository = TaskRepository();
  static final TaskBloc instance = TaskBloc._instance();
  final _taskController = StreamController<List<TaskItem>>();

  TaskBloc._instance();

  Stream<List<TaskItem>> get taskController => _taskController.stream;

  void fetchAllTasks() async {
    await taskRepository.db();
    List<TaskItem> tasks = await taskRepository.getAllTasks();
    _taskController.sink.add(tasks);
  }

  void addNewTask(TaskItem item) async {
    await taskRepository.addTask(item);
    fetchAllTasks();
  }

  void updateTask(TaskItem item) async {
    await taskRepository.updateTask(item);
    fetchAllTasks();
  }

  void deleteTask(int id) async {
    await taskRepository.deleteTask(id);
    fetchAllTasks();
  }

  void deleteAll() async {
    await taskRepository.deleteAll();
    fetchAllTasks();
  }

  @override
  void dispose() {
    taskRepository.closeDb();
    _taskController.close();
  }
}
