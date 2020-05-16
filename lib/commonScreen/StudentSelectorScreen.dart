import 'package:flutter/material.dart';
import 'package:flutterappdemo/model/Class.dart';
import 'package:flutterappdemo/model/Student.dart';

class StudentSelectorScreen extends StatelessWidget {
  static const routeName = '/select/student';

  @override
  Widget build(BuildContext context) {
    final students = ModalRoute.of(context).settings.arguments as List<Student>;
    return Scaffold(
      appBar: AppBar(
        title: Text("Student"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            Student s = students.elementAt(index);

            return GestureDetector(
              onTap: () => {
                Navigator.pop(context, s),
              },
              child: Column(
                children: <Widget>[
                  Divider(
                    height: 12.0,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(s.pic),
                    ),
                    title: Text(s.name),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
