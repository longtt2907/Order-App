import 'package:demo_12_03/Screen/Login/Components/background.dart';
import 'package:demo_12_03/components/round_button.dart';
import 'package:demo_12_03/components/text_field_container.dart';
import 'package:demo_12_03/components/text_input_field.dart';
import 'package:demo_12_03/constants.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);
  void Login() {}
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Q'Quyt",
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: size.width * 0.15,
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 25),
        ),
        Text('Login',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        TextFieldContainer(
            child: RoundedInputField(
                hintText: 'Email', icon: Icons.person, onChanged: (value) {})),
        // Padding(padding: EdgeInsets.all(8)),
        TextFieldContainer(
          child: RoundedInputField(
            hintText: 'Password',
            icon: Icons.lock,
            onChanged: (value) {},
            suffixIcon: Icons.visibility,
          ),
        ),
        RoundButton(
            text: 'LOGIN',
            color: kPrimaryColor,
            textColor: Colors.white,
            press: () {}),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have account", style: TextStyle(color: kPrimaryColor)),
            Text("Sign up",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    ));
  }
}
