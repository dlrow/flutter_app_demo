import 'package:flutter/material.dart';
import '../model/Person.dart';
import '../util/Constants.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screen/AttendanceScreen.dart';
import '../widget/AppDrawer.dart';
import '../model/Task.dart';
import '../model/Tasks.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.TASK_SCREEN_APP_BAR_TITLE),
      ),
      drawer: AppDrawer(),
      body: Stack(
        children: <Widget>[background, content(context)],
      ),
    );
  }

  get background => Column(
        children: <Widget>[
          Expanded(
            child: Container(color: Colors.blue),
            flex: 2,
          ),
          Expanded(
            child: Container(color: Colors.white70),
            flex: 5,
          ),
        ],
      );

  Widget content(BuildContext ctx) {
    return Container(
      child: Column(
        children: <Widget>[
          header,
          grid(ctx),
        ],
      ),
    );
  }

  get header => ListTile(
        contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
        title: Consumer<Person>(
            builder: (ctx, person, _) => Text(
                  //hello username
                  'Hello ' + person.name,
                  style: TextStyle(color: Colors.white),
                )),
        trailing: CircleAvatar(),
      );

  Widget grid(BuildContext ctx) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: GridView.count(
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: 2,
          childAspectRatio: .90,
          children: buildGridCards(ctx),
        ),
      ),
    );
  }

  List<GestureDetector> buildGridCards(BuildContext ctx) {
    List<Task> tasks = new Tasks().loadTask();

    if (tasks == null || tasks.isEmpty) {
      return const <GestureDetector>[];
    }

    return tasks.map((task) {
      return new GestureDetector(
        onTap: () => {
          Navigator.pushNamed(ctx, AttendanceScreen.routeName, arguments: task),
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
