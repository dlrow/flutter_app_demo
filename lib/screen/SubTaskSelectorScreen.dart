import 'package:flutter/material.dart';
import 'package:flutterappdemo/model/SubTask.dart';
import 'package:flutterappdemo/model/Task.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SubTaskSelectorScreen extends StatelessWidget {
  static const routeName = '/select/subtask';

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context).settings.arguments as Task;
    return Scaffold(
      appBar: AppBar(
        title: Text(task.taskName),
        backgroundColor: task.taskColor,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: GridView.count(
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: 2,
          childAspectRatio: .90,
          children: buildGridCards(context, task.subTasks),
        ),
      ),
    );
  }

  List<GestureDetector> buildGridCards(BuildContext ctx, List<SubTask> subTasks) {
    if (subTasks == null || subTasks.isEmpty) {
      return const <GestureDetector>[];
    }

    return subTasks.map((task) {
      return new GestureDetector(
        onTap: () => {
          Navigator.pushNamed(ctx, task.routeName, arguments: task),
        },
        child: Card(
          elevation: 2,
          color: task.taskColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FaIcon(
                  task.icon,
                  color: Colors.white,
                ),
                //Icon(Icons.accessibility),
                Text(
                  task.taskName,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}
