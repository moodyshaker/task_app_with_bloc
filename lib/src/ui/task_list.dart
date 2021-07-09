import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/src/bloc/task_bloc.dart';
import 'package:flutter_bloc_pattern/src/models/task_model.dart';

import 'add_task.dart';
import 'widget/task_item.dart';

class Home extends StatefulWidget {
  static const String id = 'Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    TaskBloc.instance.fetchAllTasks();
  }

  @override
  void dispose() {
    TaskBloc.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTask(isUpdate: false),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'My Notes',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(
                right: 8.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Ahmed',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: AssetImage('assets/images/1.jpg'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: TaskBloc.instance.taskController,
        builder: (context, AsyncSnapshot<List<Task>> data) => data
                    .connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.red,
                  ),
                ),
              )
            : data.data.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.watch_later,
                          color: Colors.black,
                          size: 40.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'There is no notes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                    ),
                  )
                : GridView.builder(
                    itemCount: data.data.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (BuildContext context, int i) {
                      return TaskItem(
                        task: data.data[i],
                      );
                    }),
      ),
    );
  }
}
