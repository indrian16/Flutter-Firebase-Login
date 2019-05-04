import 'package:flutter/material.dart';

import 'package:login_firebase/login/login.dart';
import 'splash_screen.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Login',
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
      ),
      home: LoginPage()
    );
  }
}