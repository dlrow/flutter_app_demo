import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Student with ChangeNotifier {
  String pic;
  String name;
  String address;
  String schoolId;
  String classIds;
  

}
