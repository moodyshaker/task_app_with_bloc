import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/src/models/task_more_options.dart';

final List<TaskMoreOptions> moreOptions = [
  TaskMoreOptions(title: 'Add Image', icon: Icons.image,),
  TaskMoreOptions(title: 'Add Url', icon: Icons.attachment,),
  TaskMoreOptions(title: 'Add Todo', icon: Icons.library_add_check,),
  TaskMoreOptions(title: 'Add Record', icon: Icons.mic,),
];