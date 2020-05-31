import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterappdemo/model/BaseEntity.dart';
import 'package:flutterappdemo/model/SubTask.dart';
import 'package:flutterappdemo/screen/SplashScreen.dart';
import 'package:flutterappdemo/util/HttpHelper.dart';
import 'package:http/http.dart' as http;

import '../util/Constants.dart';

class AddClassScreen extends StatefulWidget {
  static const routeName = '/class/add';

  @override
  _AddClassScreenState createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> with Constants {
  Future<List<BaseEntity>> schools;
  BaseEntity selectedItem;

  @override
  void initState() {
    super.initState();
    String url = Constants.SERVICE_URL + '/admin/all/school';
    schools = HttpHelper.getByUrl(url);
  }

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

  Future<void> _saveClass(String name) async {
    final url = Constants.SERVICE_URL + '/class/add';
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'schoolId' : selectedItem.id,
            'className': name,
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
      await _saveClass(_nameController.text);
    } on Exception catch (error) {
      var errorMessage = 'save failed';
      log(error.toString());
      _showErrorDialog(errorMessage);
    }  finally {
      _showSuccessDialog("school saved successfully");
      setState(() {
        _isLoading = false;
      });

    }
  }

  final _nameController = TextEditingController();
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    log("build methid for AddSchool called ");
    final args = ModalRoute.of(context).settings.arguments as SubTask;
    return FutureBuilder<List<BaseEntity>>(
      future: schools,
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return SplashScreen();
          default:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (snapshot.data == null)
              return Text('Going back');
            else
              return addClassWidget(args, snapshot.data);
        }
      },
    );
  }

  Scaffold addClassWidget(SubTask args, List<BaseEntity> data) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args.taskName),
        backgroundColor: args.taskColor,
      ),
      body: content(data),
    );
  }

  Widget content(List<BaseEntity> data) {
    return Container(
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
              school(data),
              name,
              saveButton,
            ],
          ),
        ),
      );
  }

  Widget school(List<BaseEntity> data) => dropdown(data);

  get schoolName => textField(_nameController, "schoolName", Icons.school);

  get name => textField(_nameController, "ClassName", Icons.add_circle);

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

  Widget dropdown(List<BaseEntity> schoolsData) {

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Container(
        color: Color(0xfff5f5f5),
        child: DropdownButton<BaseEntity>(
          isExpanded: true,
          value: selectedItem,
          onChanged: (BaseEntity newValue) => setState(() => selectedItem = newValue),
          selectedItemBuilder: (BuildContext context) {
            return schoolsData.map<Widget>((BaseEntity item) {
              return Text(item.name);
            }).toList();
          },
          items: schoolsData.map((BaseEntity item) {
            return DropdownMenuItem<BaseEntity>(
              child: Text(item.name),
              value: item,
            );
          }).toList(),
        ),
      ),
    );
  }
}
