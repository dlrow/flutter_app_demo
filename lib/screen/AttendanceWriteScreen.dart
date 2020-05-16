import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutterappdemo/commonScreen/ClassSelectorScreen.dart';
import 'package:flutterappdemo/model/Class.dart';
import 'package:flutterappdemo/model/Student.dart';
import 'package:flutterappdemo/model/SubTask.dart';
import 'package:flutterappdemo/screen/SplashScreen.dart';
import 'package:http/http.dart' as http;
import '../model/Person.dart';
import '../util/Constants.dart';
import 'package:provider/provider.dart';

class AttendanceWriteScreen extends StatefulWidget {
  static const routeName = '/attendance/take';

  @override
  _AttendanceWriteScreenState createState() => _AttendanceWriteScreenState();
}

class _AttendanceWriteScreenState extends State<AttendanceWriteScreen>
    with Constants {
  Future<List<Student>> students;

  @override
  void initState() {
    super.initState();
    Person person = Provider.of<Person>(context, listen: false);
    students = chooseClass(person);
  }

  @override
  Widget build(BuildContext context) {
    log("build methid for AttendanceWriteScreen called ");
    Person person = Provider.of<Person>(context, listen: false);
    final args = ModalRoute.of(context).settings.arguments as SubTask;
    return FutureBuilder<List<Student>>(
      future: students,
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start');
          case ConnectionState.waiting:
            return SplashScreen();
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return attendanceWriteWidget(args);
        }
      },
    );
  }

  Scaffold attendanceWriteWidget(SubTask args) {
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

  Future<List<Student>> chooseClass(Person person) async {
    log("entering chooseClass AttendannceWriteScreen");
    List<Class> classList = [];
    Class cl = new Class();
    final fetchClassByIdsUrl =
        Constants.SERVICE_URL + '/class/get/5ebfb0b6a05cf624f38d21fc';
    try {
      final response = await http.get(fetchClassByIdsUrl);
      final responseData = json.decode(response.body);
      cl.name = responseData['className'];
      cl.desc = responseData['classId'];
      classList.add(cl);
      classList.add(cl);
    } catch (error) {
      throw error;
    }

    var selectedClass = await Navigator.pushNamed(
        context, ClassSelectorScreen.routeName,
        arguments: classList);
    List<Student> students = [];
    print(selectedClass);
    //TODO : make api call to fetch studentsList from classId
    log("exiting chooseClass AttendannceWriteScreen");
    return students;
  }
}
