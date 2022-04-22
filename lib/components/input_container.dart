import 'package:demo_12_03/constants.dart';
import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  final Widget child;
  const InputContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        border: Border.all(
            color: kPrimaryColor,
            width: size.width * 0.005,
            style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
