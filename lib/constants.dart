import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kPrimaryColor = Color(0xFFe67e22);
const kPrimaryLightColor = Color.fromARGB(255, 236, 145, 59);
const kPrimaryTextColor = Color.fromARGB(255, 201, 96, 5);
const kSuccessColor = Color(0xFF16DD38);
const kDangerColor = Colors.redAccent;
const kWarningColor = Colors.orangeAccent;
const BASE_URL = "http://192.168.1.72:5001";
const kBlackColor = Color(0xFF383838);
// const kBackgroundColor = Color.fromARGB(255, 173, 172, 172);
const kBackgroundColor = Color(0xFF8C8C8C);
var numFormat = NumberFormat('#,###,###');

class LabelText extends StatelessWidget {
  final String text;
  final Color color;
  const LabelText(
    this.text,
    this.color, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ));
  }
}

class ContentText extends StatelessWidget {
  final String text;
  final Color color;
  const ContentText(
    this.text,
    this.color, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ));
  }
}
