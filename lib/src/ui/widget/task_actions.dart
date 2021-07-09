import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/src/bloc/task_bloc.dart';
import 'package:flutter_bloc_pattern/src/models/task_arg.dart';
import 'package:flutter_bloc_pattern/src/models/task_model.dart';

import '../add_task.dart';

class TaskActions extends StatelessWidget {
  final Task task;

  TaskActions({
    @required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AddTask.id,
                  arguments: TaskArg(
                    isUpdated: true,
                    task: task,
                  ));
            },
            child: Card(
              elevation: 4.0,
              shadowColor: Colors.grey.withOpacity(0.2),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              TaskBloc.instance.deleteTask(task.id);
              Navigator.pop(context);
            },
            child: Card(
              elevation: 4.0,
              shadowColor: Colors.grey.withOpacity(0.2),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              TaskBloc.instance.deleteAll();
              Navigator.pop(context);
            },
            child: Card(
              elevation: 4.0,
              shadowColor: Colors.grey.withOpacity(0.2),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Delete All',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
