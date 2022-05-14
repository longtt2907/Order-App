import 'package:demo_12_03/components/underlined_prefix_icon_field.dart';
import 'package:demo_12_03/controllers/auth_controller.dart';
import 'package:demo_12_03/screens/ForgetPassword/forget_password_step_2_screen.dart';
import 'package:flutter/material.dart';

class ForgetPasswordStep1 extends StatefulWidget {
  const ForgetPasswordStep1({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordStep1> createState() => _ForgetPasswordStep1State();
}

class _ForgetPasswordStep1State extends State<ForgetPasswordStep1> {
  final AuthService _authService = AuthService();
  final regexString =
      r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  String _email = "";
  var _emailErr = "";
  var _emailInvalid = false;

  void checkEmail() async {
    if (_email.isNotEmpty) {
      final emailRegex = RegExp(regexString);

      if (emailRegex.hasMatch(_email)) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(child: CircularProgressIndicator()));

        await _authService.checkEmail(_email).then((isSuccess) {
          if (isSuccess) {
            Navigator.of(context).pop();

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ForgetPasswordStep2(email: _email)));
          } else {
            Navigator.of(context).pop();

            setState(() {
              _emailErr = "Email không tồn tại.";
              _emailInvalid = true;
            });
          }
        });
      } else {
        setState(() {
          _emailErr = "Email không hợp lệ.";
          _emailInvalid = true;
        });
      }
    } else {
      setState(() {
        _emailErr = "Vui lòng nhập Email.";
        _emailInvalid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Forgot Password?",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("Enter your E-mail address to recover your password",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[500])),
                  SizedBox(height: 20),
                  TextFieldUnderlinedIcon(
                      hintText: "Email",
                      icon: Icon(Icons.alternate_email),
                      errorText: _emailInvalid ? _emailErr : null,
                      onChanged: (email) {
                        setState(() {
                          _email = email!;
                          _emailInvalid = false;
                        });
                      })
                ]),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: RaisedButton(
                      onPressed: () {
                        checkEmail();
                      },
                      child: Text("Continue",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ]),
        ),
        Positioned(
            top: 40,
            left: 5,
            child: BackButton(
              onPressed: () => Navigator.of(context).pop(),
            )),
      ])),
    );
  }
}
