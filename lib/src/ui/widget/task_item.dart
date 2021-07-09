import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/src/bloc/task_bloc.dart';
import 'package:flutter_bloc_pattern/src/models/task_arg.dart';
import 'package:flutter_bloc_pattern/src/models/task_model.dart';
import 'package:intl/intl.dart';

import '../add_task.dart';
import 'task_actions.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem({
    @required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    task.title.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25.0),
                        topLeft: Radius.circular(25.0),
                      )),
                      context: context,
                      builder: (context) => TaskActions(
                        task: task,
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3.0,
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Text(
                task.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 6,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ),
            Text(
              DateFormat('dd MMM yyyy  hh:mm a').format(task.date),
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
