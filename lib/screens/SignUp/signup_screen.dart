import 'package:demo_12_03/components/underlined_prefix_icon_field.dart';
import 'package:demo_12_03/controllers/auth_controller.dart';
import 'package:demo_12_03/screens/Login/login_screen.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _authService = AuthService();
  String? _emailUser, _fullNameUser, _phoneNumberUser;
  final _formKey = GlobalKey<FormState>();

  void register() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    await _authService
        .register(_emailUser, _fullNameUser, _phoneNumberUser)
        .then((isSuccess) {
      if (isSuccess) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Login()));
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: size.width,
          height: double.infinity,
          child: Stack(children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/images/signup.png"),
                      Text("Sign up",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold)),
                      SizedBox(height: 30),
                      TextFieldUnderlinedIcon(
                          onSaved: (email) {
                            _emailUser = email;
                          },
                          hintText: "Email",
                          icon: Icon(Icons.alternate_email),
                          onChanged: (val) {}),
                      SizedBox(height: 20),
                      TextFieldUnderlinedIcon(
                          onSaved: (fullName) {
                            _fullNameUser = fullName;
                          },
                          hintText: "Full Name",
                          icon: Icon(Icons.person),
                          onChanged: (val) {}),
                      SizedBox(height: 20),
                      TextFieldUnderlinedIcon(
                          onSaved: (phoneNumber) {
                            _phoneNumberUser = phoneNumber;
                          },
                          hintText: "Phone Number",
                          icon: Icon(Icons.phone),
                          onChanged: (val) {}),
                      SizedBox(height: 20),
                      Wrap(runSpacing: 6, children: [
                        Text("By signing up, you're agree to our ",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey[600])),
                        Text("Term & Conditions",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                                fontSize: 12)),
                        Text("and ",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey[600])),
                        Text("Privacy Policy",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                                fontSize: 12))
                      ]),
                      SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: TextButton(
                            onPressed: () {
                              _formKey.currentState?.save();

                              register();
                            },
                            child: Text("Continue",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              overlayColor: MaterialStateProperty.all(
                                  Colors.white.withOpacity(0.1)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.grey[500])),
                            GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => Login())),
                                child: Text("Login",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)))
                          ])
                    ]),
              ),
            ),
            Positioned(
                top: 40,
                left: 0,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                )),
          ])),
    );
  }
}
