import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/src/bloc/task_bloc.dart';
import 'package:flutter_bloc_pattern/src/models/task_item.dart';

class AddTask extends StatefulWidget {
  final bool isUpdate;
  final TaskItem task;

  AddTask({
    @required this.isUpdate,
    this.task,
  });

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _titleController, _contentController;
  String _title, _content;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    if (widget.isUpdate) {
      _titleController.text = widget.task.title;
      _contentController.text = widget.task.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                validator: (String v) =>
                    v.isEmpty ? 'Please enter task title' : null,
                onSaved: (String v) => _title = v,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _contentController,
                validator: (String v) =>
                    v.isEmpty ? 'Please enter task content' : null,
                onSaved: (String v) => _content = v,
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_key.currentState.validate()) {
                    _key.currentState.save();
                    if (widget.isUpdate) {
                      TaskBloc.instance.updateTask(TaskItem.withId(
                        id: widget.task.id,
                        title: _title,
                        content: _content,
                        date: DateTime.now(),
                      ),);
                    } else {
                      TaskBloc.instance.addNewTask(TaskItem(
                        title: _title,
                        content: _content,
                        date: DateTime.now(),
                      ));
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Task'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
