import 'package:demo_12_03/Screen/AddFood/AddFood.dart';
import 'package:demo_12_03/Screen/HomePage/HomePage.dart';
import 'package:demo_12_03/Screen/Login/login.dart';
import 'package:demo_12_03/Screen/Order/Order.dart';
import 'package:demo_12_03/Screen/Order/OrderList.dart';
import 'package:demo_12_03/Screen/Order/Pay.dart';
import 'package:demo_12_03/constants.dart';
import 'package:flutter/material.dart';

import 'server/models/bill_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final Bill bill = Bill(
    //     id: '1',
    //     dishes: [
    //       Dish(
    //           title: 'trà sữa ôlong',
    //           price: 45000,
    //           description: ['Size M', "Kem phô mai", ""]),
    //       Dish(
    //           title: 'trà sữa lài',
    //           price: 45000,
    //           description: ['Size M', "trân châu đen", "it sua"]),
    //     ],
    //     total: 90000);

    return MaterialApp(
      title: 'App Order',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          backgroundColor: Colors.white),
      home: Order(),
      // home: OrderList(bill: bill),
    );
  }
}
