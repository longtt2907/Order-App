import 'package:flutter/material.dart';

class TextFieldUnderlinedIcon extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final Icon icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final ValueChanged<String?> onChanged;
  final ValueChanged<String?>? onSaved;

  const TextFieldUnderlinedIcon(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.onChanged,
      this.obscureText = false,
      this.suffixIcon,
      this.onSaved,
      this.errorText = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: onChanged,
        onSaved: onSaved,
        obscureText: obscureText,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            hintStyle: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
            errorText: errorText != "" ? errorText : null,
            prefixIcon: icon,
            hintText: hintText,
            suffixIcon: suffixIcon));
  }
}
