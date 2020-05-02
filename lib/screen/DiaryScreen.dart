import 'package:flutter/material.dart';
import 'package:flutterappdemo/model/Task.dart';
import '../model/Person.dart';
import '../util/Constants.dart';
import 'package:provider/provider.dart';

class DiaryScreen extends StatefulWidget {
  static const routeName = '/diary';
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> with Constants {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Task;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.taskName),
      ),
      body: Center(
        child: Text(args.taskDescription),
      ),
    );
  }
}
