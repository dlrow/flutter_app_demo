import 'package:flutter/material.dart';
import 'package:flutterappdemo/model/Task.dart';
import '../model/Person.dart';
import '../util/Constants.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatefulWidget {
  static const routeName = '/result';

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with Constants {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Task;
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
