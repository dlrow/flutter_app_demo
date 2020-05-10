import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Person with ChangeNotifier {
  String phone;
  String name;
  String address;
  String schoolId;
  String _token;
  String userType;
  List authorizedFor;
  List classIds;
  List studentIds;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    return _token;
  }

  Future<void> _authenticate(String phone, String pin) async {
    final url = 'http://10.0.2.2:8081/pt/user/v1/login';
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'phone': phone,
            'pin': pin,
          },
        ),
      );

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['accessToken'];
      name = responseData['name'];
      schoolId = responseData['schoolId'];
      userType = responseData['userType'];
      authorizedFor = responseData['authorizedFor'];
      classIds = responseData['classIds'];
      studentIds = responseData['studentIds'];
      phone = phone;
      notifyListeners();
    } catch (error) {
      throw error;
    }

    await saveUserDataToDevice();
  }

  Future saveUserDataToDevice() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode(
      {
        'token': _token,
        'name': name,
        'phone': phone,
        'schoolId': schoolId,
        'userType': userType,
        'authorizedFor': authorizedFor,
        'classIds': classIds,
        'studentIds': studentIds,
      },
    );
    prefs.setString('userData', userData);
  }

  Future<void> login(String phone, String pin) async {
    return _authenticate(phone, pin);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    _token = extractedUserData['token'];
    name = extractedUserData['name'];
    phone = extractedUserData['phone'];
    schoolId = extractedUserData['schoolId'];
    userType = extractedUserData['userType'];
    authorizedFor = extractedUserData['authorizedFor'];
    classIds = extractedUserData['classIds'];
    studentIds = extractedUserData['studentIds'];

    if (!isValidToken(_token, phone)) {
      return false;
    }
    notifyListeners();
    return true;
  }

  bool isValidToken(String token, String phone) {
    //TODO make a rest call to confirm if token is valid
    if (token == null) return false;
    return true;
  }

  Future<void> logout() async {
    _token = null;
    //name = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    prefs.clear();
  }
}
