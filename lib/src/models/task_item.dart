import 'package:flutter/material.dart';

class TaskItem {
  int id;
  String title;
  String content;
  DateTime date;

  TaskItem.withId({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.date,
  });

  TaskItem({
    @required this.title,
    @required this.content,
    @required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      'content': content,
      'title': title,
      'date': date.toIso8601String(),
    };
  }

  factory TaskItem.fromMap(Map<String, dynamic> map) {
    return TaskItem.withId(
      id: map['_id'],
      title: map['title'],
      content: map['content'],
      date: DateTime.parse(map['date']),
    );
  }
}
