import 'package:demo_12_03/Screen/AddFood/AddFood.dart';
import 'package:demo_12_03/Screen/AddOption_tamthoi/AddOption_main.dart';
import 'package:demo_12_03/Screen/HomePage/HomePage.dart';
import 'package:demo_12_03/Screen/Login/login.dart';
import 'package:demo_12_03/Screen/Order/Order.dart';
import 'package:demo_12_03/Screen/Order/Pay.dart';
import 'package:demo_12_03/constants.dart';
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
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          backgroundColor: Colors.white),
      home: AddOptionMain(),
    );
  }
}
