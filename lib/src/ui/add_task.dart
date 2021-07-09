import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/src/bloc/task_bloc.dart';
import 'package:flutter_bloc_pattern/src/models/task_model.dart';
import 'package:flutter_bloc_pattern/src/ui/widget/more_options_bottom_sheet.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../style.dart';

class AddTask extends StatefulWidget {
  static const String id = 'AddTask';
  final bool isUpdate;
  final Task task;

  AddTask({
    @required this.isUpdate,
    this.task,
  });

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _titleController,
      _contentController,
      _descriptionController;
  FocusNode _titleNode, _contentNode, _descriptionNode;
  String _title, _content;
  Color _color = Colors.yellowAccent[700];
  AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _descriptionController = TextEditingController();
    _titleNode = FocusNode();
    _contentNode = FocusNode();
    _descriptionNode = FocusNode();
    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
    _rotationController.addListener(() {
      setState(() {});
    });
    if (widget.isUpdate) {
      _titleController.text = widget.task.title;
      _contentController.text = widget.task.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _descriptionController.dispose();
    _descriptionNode.dispose();
    _titleNode.dispose();
    _contentNode.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              _rotationController.forward();
              await showModalBottomSheet(
                context: context,
                shape: bottomSheetRadius,
                builder: (context) => MoreOptionsBottomSheet(),
              );
              _rotationController.reverse();
            },
            icon: Transform.rotate(
              angle: _rotationController.value * pi,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.black54,
                  ),
                ),
                child: Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.black54,
                ),
              ),
            ),
          )
        ],
        title: Text(
          'New Task',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                focusNode: _titleNode,
                controller: _titleController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_contentNode);
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: InputBorder.none,
                ),
                validator: (String v) =>
                    v.isEmpty ? 'Please enter task title' : null,
                onSaved: (String v) => _title = v,
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                '${DateFormat('dd MMM yyyy hh:mm a').format(DateTime.now())}',
                style: TextStyle(
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Container(
                    width: 5.0,
                    height: 54.0,
                    color: _color,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      focusNode: _contentNode,
                      controller: _contentController,
                      textInputAction: TextInputAction.done,
                      maxLines: 2,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionNode);
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Content',
                        border: InputBorder.none,
                      ),
                      validator: (String v) =>
                          v.isEmpty ? 'Please enter task content' : null,
                      onSaved: (String v) => _content = v,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                focusNode: _descriptionNode,
                controller: _descriptionController,
                textInputAction: TextInputAction.done,
                maxLines: 5,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (_) {
                  _descriptionNode.unfocus();
                },
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: InputBorder.none,
                ),
                validator: (String v) =>
                    v.isEmpty ? 'Please enter task description' : null,
                onSaved: (String v) => _content = v,
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (_key.currentState.validate()) {
                    _key.currentState.save();
                    if (widget.isUpdate) {
                      TaskBloc.instance.updateTask(
                        Task.withId(
                          id: widget.task.id,
                          title: _title,
                          content: _content,
                          date: DateTime.now(),
                        ),
                      );
                    } else {
                      TaskBloc.instance.addNewTask(Task(
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
                    _color,
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
