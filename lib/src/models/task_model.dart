import 'package:flutter/material.dart';

class Task {
  int id;
  String title;
  String content;
  String imageUrl;
  DateTime date;

  Task.withId({
    @required this.id,
    @required this.title,
    @required this.content,
    this.imageUrl,
    @required this.date,
  });

  Task({
    @required this.title,
    @required this.content,
    @required this.date,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      'content': content,
      'title': title,
      if (imageUrl != null) 'image': imageUrl,
      'date': date.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
      id: map['_id'],
      title: map['title'],
      content: map['content'],
      imageUrl: map['image'],
      date: DateTime.parse(map['date']),
    );
  }
}
