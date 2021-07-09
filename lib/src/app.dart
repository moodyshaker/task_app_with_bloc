import 'package:flutter/material.dart';

import 'models/task_arg.dart';
import 'ui/add_task.dart';
import 'ui/task_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: Home.id,
      routes: {
        Home.id: (context) => Home(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == AddTask.id) {
          final TaskArg arg = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => AddTask(
              isUpdate: arg.isUpdated,
              task: arg.task,
            ),
          );
        }
        return null;
      },
    );
  }
}
