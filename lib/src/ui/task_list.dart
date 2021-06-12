import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/src/bloc/movie_bloc.dart';
import 'package:flutter_bloc_pattern/src/bloc/task_bloc.dart';
import 'package:flutter_bloc_pattern/src/models/movie_response.dart';
import 'package:flutter_bloc_pattern/src/models/task_item.dart';
import 'package:intl/intl.dart';

import 'add_task.dart';

class Home extends StatefulWidget {
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
    final size = MediaQuery.of(context).size;
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
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: StreamBuilder(
        stream: TaskBloc.instance.taskController,
        builder: (context, AsyncSnapshot<List<TaskItem>> data) => data
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
                          'There is no data',
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
                                      data.data[i].title.toUpperCase(),
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
                                          builder: (context) => Padding(
                                                padding: EdgeInsets.all(20.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    AddTask(
                                                              isUpdate: true,
                                                              task:
                                                                  data.data[i],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Card(
                                                        elevation: 4.0,
                                                        shadowColor: Colors.grey
                                                            .withOpacity(0.2),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Edit',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10.0,
                                                              ),
                                                              Icon(
                                                                Icons.edit,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        TaskBloc.instance
                                                            .deleteTask(data
                                                                .data[i].id);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Card(
                                                        elevation: 4.0,
                                                        shadowColor: Colors.grey
                                                            .withOpacity(0.2),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Delete',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10.0,
                                                              ),
                                                              Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ));
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
                                  data.data[i].content,
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
                                DateFormat('dd MMM yyyy  hh:mm a')
                                    .format(data.data[i].date),
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
                    }),
      ),
    );
  }
}
