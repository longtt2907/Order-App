import 'package:demo_12_03/constants.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final IconData? suffixIcon;
  const RoundedInputField({
    Key? key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(icon, color: kPrimaryColor),
          hintText: hintText,
          border: InputBorder.none,
          suffixIcon: Icon(suffixIcon, color: kPrimaryColor),
        ));
  }
}
