import 'package:demo_12_03/screens/HomePage/HomePage.dart';
import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/screens/Login/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Order',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Montserrat",
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          backgroundColor: Colors.white),
      home: HomePage(),
    );
  }
}
