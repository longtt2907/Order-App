import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFe67e22);
const kPrimaryLightColor = Color.fromARGB(255, 236, 145, 59);
const kPrimaryTextColor = Color.fromARGB(255, 201, 96, 5);
const kBackgroundColor = Color.fromARGB(255, 202, 201, 201);
const BASE_URL = "http://172.16.30.186:5000";

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
