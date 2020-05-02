import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Task {
  String taskName;
  IconData icon;
  Color taskColor;
  String taskDescription;
  String routeName;

  Task(this.taskName, this.icon, this.taskColor, this.taskDescription, this.routeName);
}
