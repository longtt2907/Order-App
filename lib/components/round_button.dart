import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;

  const RoundButton({
    Key? key,
    required this.press,
    required this.color,
    required this.textColor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.9,
        constraints: BoxConstraints(minHeight: 40),
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(color),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
                // textStyle: MaterialStateProperty.all<TextStyle>(
                //     TextStyle(color: Colors.white)),
              ),
              child: Text(
                text,
                style: TextStyle(color: textColor),
              ),
              onPressed: press(),
            )));
  }
}
