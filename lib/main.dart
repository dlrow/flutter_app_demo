import 'package:flutter/material.dart';
import 'util/Constants.dart';
import 'package:provider/provider.dart';
import 'screen/LoginScreen.dart';
import 'screen/DashboardScreen.dart';
import 'screen/AttendanceScreen.dart';
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
              AttendanceScreen.routeName: (ctx) => AttendanceScreen()
            }),
      ),
    );
  }
}
