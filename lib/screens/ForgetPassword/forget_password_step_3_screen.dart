import 'package:demo_12_03/components/underlined_prefix_icon_field.dart';
import 'package:demo_12_03/controllers/auth_controller.dart';
import 'package:demo_12_03/screens/Login/login_screen.dart';
import 'package:flutter/material.dart';

class ForgetPasswordStep3 extends StatefulWidget {
  final String email;
  final String pin;
  const ForgetPasswordStep3({Key? key, required this.email, required this.pin})
      : super(key: key);

  @override
  State<ForgetPasswordStep3> createState() => _ForgetPasswordStep3State();
}

class _ForgetPasswordStep3State extends State<ForgetPasswordStep3> {
  final AuthService _authService = AuthService();
  String _password = "";
  String _confirmPassword = "";
  bool _isShowPassword = false;
  String _passwordErr = "";
  bool _passwordInvalid = false;

  void handleSubmit() async {
    if (_password.trim() == "" || _password.trim() == "") {
      setState(() {
        _passwordErr = "Vui lòng nhập mật khẩu";
        _passwordInvalid = true;
      });
    } else if (_password.trim().length < 6) {
      setState(() {
        _passwordErr = "Mật khẩu phải lớn hơn 6 kí tự";
        _passwordInvalid = true;
      });
    } else if (_password.trim() != _confirmPassword.trim()) {
      setState(() {
        _passwordErr = "Xác nhận mật khẩu không đúng";
        _passwordInvalid = true;
      });
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(child: CircularProgressIndicator()));

      await _authService
          .recoverPassword(widget.email, widget.pin, _password)
          .then((isSuccess) {
        if (isSuccess) {
          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Login()));
        } else {
          Navigator.of(context).pop();

          setState(() {
            _passwordErr = "Cập nhật mật khẩu thất bại";
            _passwordInvalid = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: size.width,
          height: double.infinity,
          child: Stack(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Set new password",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(
                        "Your new password must be different from previously used passwords.",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[500])),
                    SizedBox(height: 20),
                    Expanded(
                      child: Form(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            Column(children: [
                              TextFieldUnderlinedIcon(
                                  hintText: "Password",
                                  obscureText: !_isShowPassword,
                                  icon: Icon(Icons.lock),
                                  onChanged: (val) {
                                    setState(() {
                                      _password = val!;
                                      _passwordInvalid = false;
                                    });
                                  }),
                              SizedBox(height: 20),
                              TextFieldUnderlinedIcon(
                                  hintText: "Confirm Password",
                                  obscureText: !_isShowPassword,
                                  icon: Icon(Icons.lock),
                                  onChanged: (val) {
                                    setState(() {
                                      _confirmPassword = val!;
                                      _passwordInvalid = false;
                                    });
                                  }),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_passwordInvalid ? _passwordErr : "",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: _isShowPassword,
                                            onChanged: (val) {
                                              setState(() {
                                                _isShowPassword =
                                                    !_isShowPassword;
                                              });
                                            }),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _isShowPassword =
                                                  !_isShowPassword;
                                            });
                                          },
                                          child: Container(
                                            width: 50,
                                            child: Text(
                                                _isShowPassword
                                                    ? "Hide"
                                                    : "Show",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                      ],
                                    )
                                  ])
                            ]),
                            Container(
                              width: double.infinity,
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: RaisedButton(
                                    onPressed: () {
                                      handleSubmit();
                                    },
                                    child: Text("Submit",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    color: Colors.blue),
                              ),
                            ),
                          ])),
                    )
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
