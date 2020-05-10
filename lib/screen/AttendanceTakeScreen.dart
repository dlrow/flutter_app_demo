import 'package:flutter/material.dart';
import 'package:flutterappdemo/model/SubTask.dart';
import 'package:flutterappdemo/model/Task.dart';
import '../model/Person.dart';
import '../util/Constants.dart';
import 'package:provider/provider.dart';

class AttendanceTakeScreen extends StatefulWidget {
  static const routeName = '/attendance/take';

  @override
  _AttendanceTakeScreenState createState() => _AttendanceTakeScreenState();
}

class _AttendanceTakeScreenState extends State<AttendanceTakeScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as SubTask;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.taskName),
        backgroundColor: args.taskColor,
      ),
      body: Center(
        child: Text("This is take attendance screen"),
      ),
    );
  }
}
