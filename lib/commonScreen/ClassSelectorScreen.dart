import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterappdemo/model/Class.dart';

//takes list of class as argument displays them in ListView and returns the selected class
class ClassSelectorScreen extends StatelessWidget {
  static const routeName = '/select/class';

  @override
  Widget build(BuildContext context) {
    log("build methid for ClassSelectorScreen called ");
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

            return Column(
              children: <Widget>[
                Divider(
                  height: 12.0,
                ),
                ListTile(
                  onTap: () => {
                    Navigator.pop(context, cl),
                  },
                  title: Text(cl.name),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
