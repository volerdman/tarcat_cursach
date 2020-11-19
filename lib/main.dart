import 'package:flutter/material.dart';
import 'package:tarcat_kursach/screens/login/login_screen.dart';
import 'package:tarcat_kursach/screens/register/register_form.dart';
import 'package:tarcat_kursach/screens/register/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff6a515e),
        cursorColor: Color(0xff6a515e),
      ),
      home: LoginScreen(),
    );
  }
}
