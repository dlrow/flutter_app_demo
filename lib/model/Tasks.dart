import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdemo/model/SubTask.dart';
import 'package:flutterappdemo/screen/AddClassScreen.dart';
import 'package:flutterappdemo/screen/AddSchoolScreen.dart';
import 'package:flutterappdemo/screen/AttendanceViewScreen.dart';
import 'package:flutterappdemo/screen/AttendanceWriteScreen.dart';
import 'package:flutterappdemo/screen/DiaryScreen.dart';
import 'package:flutterappdemo/screen/NoticeScreen.dart';
import 'package:flutterappdemo/util/Constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './Task.dart';
import 'Person.dart';

class Tasks with Constants {
  static final SubTask attendanceWrite = new SubTask(
      "Take Attendance",
      FontAwesomeIcons.calendar,
      Color.fromARGB(200, 40, 181, 85),
      "show attendance of logged in student",
      AttendanceWriteScreen.routeName);

  static final SubTask attendanceView = new SubTask(
      "View Attendance",
      FontAwesomeIcons.calendar,
      Color.fromARGB(200, 40, 181, 85),
      "show attendance of logged in student",
      AttendanceViewScreen.routeName);

  final Task attendance = new Task(
      "Attendance",
      FontAwesomeIcons.calendar,
      Color.fromARGB(200, 40, 181, 85),
      "show attendance of logged in student",
      AttendanceViewScreen.routeName,
      [attendanceView]);

  static final SubTask diaryWrite = new SubTask(
      "Write Diary",
      FontAwesomeIcons.book,
      Color.fromARGB(200, 245, 148, 67),
      "show datewise diary/homework of logged in student",
      DiaryScreen.routeName);

  static final SubTask diaryRead = new SubTask(
      "Read Diary",
      FontAwesomeIcons.book,
      Color.fromARGB(200, 245, 148, 67),
      "show datewise diary/homework of logged in student",
      DiaryScreen.routeName);

  final Task diary = new Task(
      "Diary",
      FontAwesomeIcons.book,
      Color.fromARGB(200, 245, 148, 67),
      "show datewise diary/homework of logged in student",
      DiaryScreen.routeName,
      [diaryRead]);

  static final SubTask noticeRead = new SubTask(
      "Notice Read",
      FontAwesomeIcons.stickyNote,
      Color.fromARGB(200, 106, 27, 150),
      "this is notice screen",
      NoticeScreen.routeName);

  static final SubTask noticeWrite = new SubTask(
      "Notice Write",
      FontAwesomeIcons.stickyNote,
      Color.fromARGB(200, 106, 27, 150),
      "this is notice screen",
      NoticeScreen.routeName);

  final Task notice = new Task(
      "Notice",
      FontAwesomeIcons.stickyNote,
      Color.fromARGB(200, 106, 27, 150),
      "this is notice screen",
      NoticeScreen.routeName,
      [noticeRead]);

  static final SubTask addSchoolSubTask = new SubTask(
      "Add School ",
      FontAwesomeIcons.school,
      Color.fromARGB(200, 106, 27, 150),
      "Add School ",
      AddSchoolScreen.routeName);

  static final SubTask addClassSubTask = new SubTask(
      "Add Class ",
      FontAwesomeIcons.school,
      Color.fromARGB(200, 106, 27, 150),
      "Add Class ",
      AddClassScreen.routeName);

  final Task adminTask = new Task(
      "Admin ",
      Icons.person,
      Color.fromARGB(200, 106, 27, 150),
      "Admin screen",
      AddSchoolScreen.routeName,
      [addSchoolSubTask, addClassSubTask]);

  /* final Task timeTable = new Task(
      "Time Table",
      FontAwesomeIcons.clock,
      Color.fromARGB(200, 63, 40, 22),
      "this shows time table of logged in",
      TimeTableScreen.routeName);
  final Task remarks = new Task(
      "Remarks",
      FontAwesomeIcons.comment,
      Color.fromARGB(200, 63, 245, 179),
      "teacher/parent remarks",
      RemarkScreen.routeName);
  final Task holidays = new Task(
      "Holidays",
      FontAwesomeIcons.cloudSunRain,
      Color.fromARGB(200, 222, 94, 192),
      "you can see public holidays",
      HolidayScreen.routeName);

  final Task exam = new Task("Exam", FontAwesomeIcons.bookReader,
      Color.fromARGB(200, 8, 100, 156), "Exam schedule", ExamScreen.routeName);

  final Task result = new Task("Result", FontAwesomeIcons.poll,
      Color.fromARGB(200, 227, 68, 68), "Exam results", ResultScreen.routeName);*/

  List<Task> loadTask(Person p) {
    log("loadTask called in Tasks class");
    String userType = p.userType.toString();
    List<Task> tasks = [];
    if (userType == Constants.ADMIN) {
      tasks.add(adminTask);
    }

    if (userType == Constants.ADMIN || userType == Constants.TEACHER) {
      attendance.subTasks.add(attendanceWrite);
      diary.subTasks.add(diaryWrite);
      notice.subTasks.add(noticeWrite);
    }
    tasks.add(attendance);
    tasks.add(diary);
    tasks.add(notice);
    return tasks;
  }
}
