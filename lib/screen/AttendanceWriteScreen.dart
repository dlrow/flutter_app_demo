import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutterappdemo/commonScreen/ClassSelectorScreen.dart';
import 'package:flutterappdemo/model/Class.dart';
import 'package:flutterappdemo/model/Student.dart';
import 'package:flutterappdemo/model/SubTask.dart';
import 'package:flutterappdemo/screen/SplashScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    students = getStudents(person);
  }

  @override
  Widget build(BuildContext context) {
    log("build methid for AttendanceWriteScreen called ");
    final args = ModalRoute.of(context).settings.arguments as SubTask;
    return FutureBuilder<List<Student>>(
      future: students,
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return SplashScreen();
          default:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (snapshot.data == null)
              return Text('Going back');
            else
              return attendanceWriteWidget(args, snapshot.data);
        }
      },
    );
  }

  Scaffold attendanceWriteWidget(SubTask args, List<Student> students) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args.taskName),
        backgroundColor: args.taskColor,
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          Student s = students.elementAt(index);

          return Column(
            children: <Widget>[
              Divider(
                height: 12.0,
              ),
              ListTile(
                leading: CircleAvatar(
                    // backgroundImage: NetworkImage(s.pic),
                    ),
                title: Text(s.name),
                trailing: GestureDetector(
                  onTap: (){

                  },
                  child: FaIcon(
                    FontAwesomeIcons.checkCircle,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<List<Student>> getStudents(Person person) async {
    log("entering getStudents AttendannceWriteScreen");
    List<Class> classList = [];

    var uri = Uri(
      scheme: 'http',
      host: Constants.HOST,
      port: Constants.PORT,
      path: '/pt/class/listByIds',
      queryParameters: {
        'listOfClassIds': person.classIds,
      },
    );

    try {
      final classResponse = await http.get(uri);
      final classResponseData = json.decode(classResponse.body) as List;

      for (int i = 0; i < classResponseData.length; i++) {
        Class cl = new Class();
        cl.name = classResponseData[i]['className'];
        cl.desc = classResponseData[i]['classId'];
        classList.add(cl);
      }
    } catch (error) {
      log(error);
    }

    Class selectedClass = await Navigator.pushNamed(
        context, ClassSelectorScreen.routeName,
        arguments: classList) as Class;

    if (selectedClass == null) {
      Navigator.pop(context);
      return null;
    }

    List<Student> students = [];
    final fetchStudentByClassIdsUrl =
        Constants.SERVICE_URL + 'student/allstudent/' + selectedClass.desc;
    try {
      final studentResponse = await http.get(fetchStudentByClassIdsUrl);
      final studentResponseData = json.decode(studentResponse.body) as List;
      for (int i = 0; i < studentResponseData.length; i++) {
        Student st = new Student();
        st.name = studentResponseData[i]['firstName'];
        st.address = studentResponseData[i]['classId'];
        students.add(st);
      }
    } catch (error) {
      log(error);
    }
    log("exiting getStudents AttendannceWriteScreen");
    return students;
  }
}
