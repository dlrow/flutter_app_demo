import 'package:flutter/material.dart';

class SubTask {
  String taskName;
  IconData icon;
  Color taskColor;
  String taskDescription;
  String routeName;

  SubTask(this.taskName, this.icon, this.taskColor, this.taskDescription,
      this.routeName);
}
