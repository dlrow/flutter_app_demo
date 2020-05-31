import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterappdemo/model/SubTask.dart';
import 'package:http/http.dart' as http;

import '../util/Constants.dart';

class AddSchoolScreen extends StatefulWidget {
  static const routeName = '/school/add';

  @override
  _AddSchoolScreenState createState() => _AddSchoolScreenState();
}

class _AddSchoolScreenState extends State<AddSchoolScreen> with Constants {
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Save successfull!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _saveSchool(String address, String pinCode, String city,
      String name, String state) async {
    final url = Constants.SERVICE_URL + '/admin/add/school';
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'schoolAddress': address,
            'schoolCity': city,
            'schoolName': name,
            'schoolPincode': pinCode,
            'schoolState': state,
            'isSchoolDeleted': false,
          },
        ),
      );

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      // _token = responseData['accessToken'];

    } catch (error) {
      throw error;
    }
  }

  Future<void> _submit() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await _saveSchool(_addressController.text, _pinCodeController.text,
          _cityController.text, _nameController.text, _stateController.text);
    } on Exception catch (error) {
      var errorMessage = 'save failed';
      _showErrorDialog(errorMessage);
    }  finally {
      _showSuccessDialog("school saved successfully");
      setState(() {
        _isLoading = false;
      });

    }
  }

  final _nameController = TextEditingController();
  final _stateController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    log("build methid for AddSchool called ");
    final args = ModalRoute.of(context).settings.arguments as SubTask;
    return attendanceWriteWidget(args);
  }

  Scaffold attendanceWriteWidget(SubTask args) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args.taskName),
        backgroundColor: args.taskColor,
      ),
      body: content,
    );
  }

  get content => Container(
        //width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(23),
          child: ListView(
            children: <Widget>[
              schoolName,
              address,
              city,
              state,
              pincode,
              saveButton,
            ],
          ),
        ),
      );

  get schoolName => textField(_nameController, "schoolName", Icons.school);

  get address => textField(_addressController, "Address", Icons.home);

  get city => textField(_cityController, "City", Icons.add_circle);

  get state => textField(_stateController, "State", Icons.add_circle);

  get pincode => textField(_pinCodeController, "Pincode", Icons.add_circle);

  Widget textField(var controller, String labelText, IconData icon) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Container(
        color: Color(0xfff5f5f5),
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: labelText,
              prefixIcon: Icon(icon),
              labelStyle: TextStyle(fontSize: 15)),
        ),
      ),
    );
  }

  get saveButton {
    if (_isLoading)
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: CircularProgressIndicator(),
        ),
      );
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: MaterialButton(
        onPressed: _submit,
        //since this is only a UI app
        child: Text(
          'SAVE',
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'SFUIDisplay',
            fontWeight: FontWeight.bold,
          ),
        ),
        color: Color(0xffff2d55),
        elevation: 0,
        minWidth: 400,
        height: 50,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
