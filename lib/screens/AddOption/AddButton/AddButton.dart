import 'package:demo_12_03/constants.dart';
import "package:flutter/material.dart";

class AddButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function onPressed;
  final Color? backgroundColor;
  const AddButton({
    Key? key,
    required this.color,
    required this.text,
    this.backgroundColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
            child: Text(text,
                style: TextStyle(
                    color: Colors.white, fontSize: size.width * 0.04)),
            onPressed: onPressed(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  color != null ? color : kPrimaryColor),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
              minimumSize: MaterialStateProperty.all<Size>(
                  Size.fromHeight(size.height * 0.08)),
            )),
      ),
    );
  }
}
