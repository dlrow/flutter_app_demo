import 'package:flutter/cupertino.dart';
import 'package:flutterappdemo/screen/AttendanceScreen.dart';
import 'package:flutterappdemo/screen/DiaryScreen.dart';
import 'package:flutterappdemo/screen/ExamScreen.dart';
import 'package:flutterappdemo/screen/HolidaysScreen.dart';
import 'package:flutterappdemo/screen/NoticeScreen.dart';
import 'package:flutterappdemo/screen/RemarkScreen.dart';
import 'package:flutterappdemo/screen/ResultScreen.dart';
import 'package:flutterappdemo/screen/TimeTableScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './Task.dart';

class Tasks {
  List<Task> loadTask() {
    List<Task> tasks = [
      new Task(
          "Attendance",
          FontAwesomeIcons.calendar,
          Color.fromARGB(200, 40, 181, 85),
          "show attendance of logged in student",
          AttendanceScreen.routeName),
      new Task(
          "Diary",
          FontAwesomeIcons.book,
          Color.fromARGB(200, 245, 148, 67),
          "show datewise diary/homework of logged in student",
          DiaryScreen.routeName),
      new Task(
          "Notice",
          FontAwesomeIcons.stickyNote,
          Color.fromARGB(200, 106, 27, 150),
          "this is notice screen",
          NoticeScreen.routeName),
      new Task(
          "Time Table",
          FontAwesomeIcons.clock,
          Color.fromARGB(200, 63, 40, 22),
          "this shows time table of logged in",
          TimeTableScreen.routeName),
      new Task(
          "Remarks",
          FontAwesomeIcons.comment,
          Color.fromARGB(200, 63, 245, 179),
          "teacher/parent remarks",
          RemarkScreen.routeName),
      new Task(
          "Holidays",
          FontAwesomeIcons.cloudSunRain,
          Color.fromARGB(200, 222, 94, 192),
          "you can see public holidays",
          HolidayScreen.routeName),
      new Task(
          "Exam",
          FontAwesomeIcons.bookReader,
          Color.fromARGB(200, 8, 100, 156),
          "Exam schedule",
          ExamScreen.routeName),
      new Task(
          "Result",
          FontAwesomeIcons.poll,
          Color.fromARGB(200, 227, 68, 68),
          "Exam results",
          ResultScreen.routeName),
    ];
    return tasks;
  }
}
