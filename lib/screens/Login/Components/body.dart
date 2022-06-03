import 'package:demo_12_03/components/underlined_prefix_icon_field.dart';
import 'package:demo_12_03/controllers/auth_controller.dart';
import 'package:demo_12_03/screens/ForgetPassword/forget_password_step_1_screen.dart';
import 'package:demo_12_03/screens/HomePage/HomePage.dart';
import 'package:demo_12_03/screens/Login/Components/background.dart';
import 'package:demo_12_03/components/round_button.dart';
import 'package:demo_12_03/components/text_field_container.dart';
import 'package:demo_12_03/components/text_input_field.dart';
import 'package:demo_12_03/constants.dart';
import 'package:demo_12_03/screens/Login/login_screen.dart';
import 'package:demo_12_03/screens/SignUp/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _authService = AuthService();
  bool _isShowPassword = false;
  String _email = "";
  String _password = "";

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   WidgetsBinding.instance?.addPostFrameCallback((_) {
  //     const snackBar = SnackBar(
  //         content: Text(
  //           "Cập nhật mật khẩu thành công",
  //           style: TextStyle(
  //             color: Color(0xFF5cb85c),
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //         backgroundColor: Colors.white);

  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   });
  // }

  void handleSubmit() async {
    final prefs = await SharedPreferences.getInstance();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));

    await _authService.login(_email, _password).then((userId) {
      if (userId.contains("")) {
        prefs.setString("user_id", userId);
        Navigator.of(context).pop();
        String? userIdd = prefs.getString("user_id");
        print(userIdd);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Image.asset("assets/images/login.png", width: size.width * 2 / 3),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Login",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              SizedBox(height: 30),
              TextFieldUnderlinedIcon(
                  icon: Icon(Icons.alternate_email),
                  hintText: "Email",
                  onChanged: (val) {
                    setState(() {
                      _email = val!;
                    });
                  }),
              SizedBox(height: 20),
              Stack(alignment: AlignmentDirectional.centerEnd, children: [
                TextFieldUnderlinedIcon(
                    icon: Icon(Icons.lock),
                    hintText: "Password",
                    obscureText: !_isShowPassword,
                    onChanged: (val) {
                      setState(() {
                        _password = val!;
                      });
                    }),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _isShowPassword = !_isShowPassword;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(_isShowPassword ? "Hide" : "Show",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          )),
                    ))
              ]),
              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ForgetPasswordStep1())),
                  child: Text("Forgot Password?",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w700)),
                ),
              ]),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: RaisedButton(
                    onPressed: () => handleSubmit(),
                    color: Colors.blue,
                    child: Text("Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              OrDivider(size: size),
              Container(
                width: double.infinity,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: RaisedButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        SizedBox(width: 30),
                        Image.asset("assets/images/google.png",
                            height: 30, fit: BoxFit.contain),
                        SizedBox(width: 30),
                        Text("Login with Google",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    color: Colors.grey[200],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Do not have an account? ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[500])),
                GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUp())),
                    child: Text("Register",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue)))
              ])
            ]),
          )
        ],
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: size.width,
      child: Row(
        children: <Widget>[
          buildExpanded(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              style: TextStyle(
                  color: Colors.grey[300], fontWeight: FontWeight.w600),
            ),
          ),
          buildExpanded(),
        ],
      ),
    );
  }

  Expanded buildExpanded() {
    return Expanded(
        child: Divider(
      color: Color(0xFF666666),
      height: 1.5,
    ));
  }
}
