import 'package:flutter/material.dart';
import 'package:flutterappdemo/screen/AttendanceTakeScreen.dart';
import 'package:flutterappdemo/screen/AttendanceViewScreen.dart';
import 'package:flutterappdemo/screen/DiaryScreen.dart';
import 'package:flutterappdemo/screen/ExamScreen.dart';
import 'package:flutterappdemo/screen/HolidaysScreen.dart';
import 'package:flutterappdemo/screen/NoticeScreen.dart';
import 'package:flutterappdemo/screen/ProfileScreen.dart';
import 'package:flutterappdemo/screen/RemarkScreen.dart';
import 'package:flutterappdemo/screen/ResultScreen.dart';
import 'package:flutterappdemo/screen/SubTaskSelectorScreen.dart';
import 'package:flutterappdemo/screen/TimeTableScreen.dart';
import 'util/Constants.dart';
import 'package:provider/provider.dart';
import 'screen/LoginScreen.dart';
import 'screen/DashboardScreen.dart';
import 'model/Person.dart';
import 'screen/SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Person(),
        ),
      ],
      child: Consumer<Person>(
        builder: (ctx, person, _) => MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
              accentColor: Colors.deepOrange,
              //fontFamily: 'Lato',
            ),
            home: person.isAuth
                ? DashboardScreen()
                : FutureBuilder(
                    future: person.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : LoginScreen(),
                  ),
            // debugShowCheckedModeBanner: false,
            routes: {
              LoginScreen.routeName: (ctx) => LoginScreen(),
              DashboardScreen.routeName: (ctx) => DashboardScreen(),
              SubTaskSelectorScreen.routeName: (ctx) => SubTaskSelectorScreen(),
              AttendanceViewScreen.routeName: (ctx) => AttendanceViewScreen(),
              AttendanceTakeScreen.routeName: (ctx) => AttendanceTakeScreen(),
              DiaryScreen.routeName: (ctx) => DiaryScreen(),
              ExamScreen.routeName: (ctx) => ExamScreen(),
              HolidayScreen.routeName: (ctx) => HolidayScreen(),
              NoticeScreen.routeName: (ctx) => NoticeScreen(),
              ExamScreen.routeName: (ctx) => ExamScreen(),
              ProfileScreen.routeName: (ctx) => ProfileScreen(),
              RemarkScreen.routeName: (ctx) => RemarkScreen(),
              ResultScreen.routeName: (ctx) => ResultScreen(),
              TimeTableScreen.routeName: (ctx) => TimeTableScreen()
            }),
      ),
    );
  }
}
