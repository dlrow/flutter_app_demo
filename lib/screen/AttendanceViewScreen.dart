import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutterappdemo/model/SubTask.dart';
import 'package:flutterappdemo/model/Task.dart';
import '../model/Person.dart';
import '../util/Constants.dart';
import 'package:provider/provider.dart';

class AttendanceViewScreen extends StatefulWidget {
  static const routeName = '/attendance/view';

  @override
  _AttendanceViewScreenState createState() => _AttendanceViewScreenState();
}

class _AttendanceViewScreenState extends State<AttendanceViewScreen> {
  static Widget _absentIcon(String day) => Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(1000)),
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      );

  EventList<Event> getAbsentDates() {

    EventList<Event> _markedDates = new EventList<Event>(
      events: {},
    );

    _markedDates.add(
        DateTime(2020, 2, 1),
        new Event(
          date: DateTime(2020, 2, 1),
          title: 'Evet 5',
          icon: _absentIcon(DateTime(2020, 2, 1).day.toString()),
        ));

    return _markedDates;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as SubTask;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.taskName),
        backgroundColor: args.taskColor,
      ),
      body: Center(
        child: CalendarCarousel<Event>(
          height: deviceHeight * 0.6,

          markedDatesMap: getAbsentDates(),
          markedDateShowIcon: true,
          markedDateIconMaxShown: 1,
          markedDateIconBuilder: (event) {
            return event.icon;
          },
        ),
      ),
    );
  }
}
