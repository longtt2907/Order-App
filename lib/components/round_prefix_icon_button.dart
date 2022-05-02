import 'package:demo_12_03/constants.dart';
import 'package:flutter/material.dart';

class RoundPrefixIconButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function press;
  final Color color, textColor;
  const RoundPrefixIconButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.press,
      required this.color,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: color,
            boxShadow: [
              BoxShadow(
                  color: kPrimaryColor.withOpacity(1),
                  blurRadius: 20,
                  offset: const Offset(0, 0))
            ]),
        child: TextButton(

            // ignore: prefer_const_constructors
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        margin: const EdgeInsets.only(left: 5),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                        child: icon)),
                Flexible(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(text.toUpperCase(),
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                )
              ],
            ),
            onPressed: () => press()));
  }
}
