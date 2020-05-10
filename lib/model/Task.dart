import 'package:flutter/material.dart';
import './SubTask.dart';

class Task {
  String taskName;
  IconData icon;
  Color taskColor;
  String taskDescription;
  String defaultRouteName;
  List<SubTask> subTasks;

  Task(this.taskName, this.icon, this.taskColor, this.taskDescription,
      this.defaultRouteName, this.subTasks);
}
