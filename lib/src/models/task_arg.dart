import 'package:flutter/material.dart';

import 'task_model.dart';

class TaskArg {
  bool isUpdated;
  Task task;

  TaskArg({
    @required this.isUpdated,
    @required this.task,
  });
}
