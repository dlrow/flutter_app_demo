import 'package:flutter/material.dart';
import 'package:flutterappdemo/model/SubTask.dart';
import 'package:flutterappdemo/model/Task.dart';
import '../model/Person.dart';
import '../util/Constants.dart';
import 'package:provider/provider.dart';

class NoticeScreen extends StatefulWidget {
  static const routeName = '/nnotice';
  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> with Constants {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as SubTask;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.taskName),
        backgroundColor: args.taskColor,
      ),
      body: Center(
        child: Text(args.taskDescription),
      ),
    );
  }
}
