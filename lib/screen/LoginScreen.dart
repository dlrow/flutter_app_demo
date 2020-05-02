import 'package:flutter/material.dart';
import '../model/Person.dart';
import '../util/Constants.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Constants {
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();
  var _isLoading = false;

  AuthMode _authMode = AuthMode.Login;

  Map<String, String> _authData = {
    'phone': '',
    'pin': '',
  };

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

  Future<void> _submit() async {
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        setState(() {
          _isLoading = true;
        });
        await Provider.of<Person>(context, listen: false)
            .login(_phoneController.text, _pinController.text);
      } else {
        // Sign user up
        /* await Provider.of<Person>(context, listen: false).signup(
          _authData['phone'],
          _authData['pin'],
        );*/
      }
    } on Exception catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /*void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text(TASK_SCREEN_APP_BAR_TITLE),),
      body: Stack(
        children: <Widget>[background, content],
      ),
    );
  }

  get background => Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/image1.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter)),
      );

  get content => Container(
        //width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 270),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(23),
          child: ListView(
            children: <Widget>[
              phoneNumField,
              pinField,
              signInButton,
              forgotPasswordButton,
            ],
          ),
        ),
      );

  get phoneNumField => Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Container(
          color: Color(0xfff5f5f5),
          child: TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone',
                prefixIcon: Icon(Icons.person_outline),
                labelStyle: TextStyle(fontSize: 15)),
            validator: (value) {
              if (value.isEmpty || value.length < 10) {
                return 'Invalid phone!';
              }
              return null;
            },
          ),
        ),
      );

  get pinField => Container(
        color: Color(0xfff5f5f5),
        child: TextFormField(
          controller: _pinController,
          obscureText: true,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'pin',
              prefixIcon: Icon(Icons.lock_outline),
              labelStyle: TextStyle(fontSize: 15)),
          validator: (value) {
            if (value.isEmpty || value.length < 40) {
              return 'Invalid pin!';
            }
            return null;
          },
        ),
      );

  get signInButton {
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
          'SIGN IN',
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

  get forgotPasswordButton => Padding(
        padding: EdgeInsets.only(top: 20),
        child: Center(
          child: Text(
            'Fogot your password?',
            style: TextStyle(
                fontFamily: 'SFUIDisplay',
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      );

/*get registerUserButton => Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                                text: "Don't have an account?",
                                style: TextStyle(
                                  fontFamily: 'SFUIDisplay',
                                  color: Colors.black,
                                  fontSize: 15,
                                )
                            ),
                            TextSpan(
                                text: "sign up",
                                style: TextStyle(
                                  fontFamily: 'SFUIDisplay',
                                  color: Color(0xffff2d55),
                                  fontSize: 15,
                                )
                            )
                          ]
                      ),
                    ),
                  ),
                )*/
}
