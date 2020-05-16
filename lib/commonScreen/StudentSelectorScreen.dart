import 'package:flutter/material.dart';
import 'package:flutterappdemo/model/Class.dart';

class StudentSelectorScreen extends StatelessWidget {
  static const routeName = '/select/student';

  @override
  Widget build(BuildContext context) {
    final classList = ModalRoute.of(context).settings.arguments as List<Class>;
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Class"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: ListView.builder(
          itemCount: classList.length,
          itemBuilder: (context, index) {
            Class cl = classList.elementAt(index);

            return GestureDetector(
              onTap: () => {
                Navigator.pop(context, cl),
              },
              child: Column(
                children: <Widget>[
                  Divider(
                    height: 12.0,
                  ),
                  ListTile(
                    title: Text(cl.name),
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
