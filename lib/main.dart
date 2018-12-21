import 'package:flutter/material.dart';
import 'package:conversando/context.dart';
import 'package:conversando/loginPage.dart';
import 'package:conversando/homePage.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextContextWidget(
      child: new MaterialApp(
        theme: ThemeData(fontFamily: "Roboto").copyWith(
          primaryColor: Colors.cyan,
          backgroundColor: Color(0xFFFDA05D)
        ),
        routes: <String, WidgetBuilder>{
          // Set routes for using the Navigator.
          '/home': (BuildContext context) => new HomePage(),
          '/login': (BuildContext context) => new LoginPage()
        },
        home: new LoginPage()
      )
    );
  }
}