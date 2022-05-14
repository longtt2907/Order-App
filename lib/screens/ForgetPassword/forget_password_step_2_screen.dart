import 'package:demo_12_03/controllers/auth_controller.dart';
import 'package:demo_12_03/screens/ForgetPassword/forget_password_step_3_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgetPasswordStep2 extends StatefulWidget {
  final String email;
  const ForgetPasswordStep2({Key? key, required this.email}) : super(key: key);

  @override
  State<ForgetPasswordStep2> createState() => _ForgetPasswordStep2State();
}

class _ForgetPasswordStep2State extends State<ForgetPasswordStep2> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  String? pin1 = "";
  String? pin2 = "";
  String? pin3 = "";
  String? pin4 = "";
  var _pinErr = "";
  var _pinInvalid = false;

  void checkPinCode(String email, String pinCode) async {
    if (pinCode.length == 4) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(child: CircularProgressIndicator()));

      await _authService.checkPinCode(email, pinCode).then((isSuccess) {
        if (isSuccess) {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ForgetPasswordStep3(email: email, pin: pinCode)));
        } else {
          Navigator.of(context).pop();

          setState(() {
            _pinErr = "Sai mã PIN";
            _pinInvalid = true;
          });
        }
      });
    } else {
      setState(() {
        _pinErr = "Vui lòng nhập mã PIN";
        _pinInvalid = true;
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Verification code",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("We have sent the code verification to",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.grey[500])),
            SizedBox(height: 5),
            Text("vuo***@gmail.com",
                style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 30),
            Expanded(
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                height: 68,
                                width: 64,
                                child: TextFormField(
                                  onSaved: (pin) {
                                    pin1 = pin;
                                  },
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                )),
                            SizedBox(
                                height: 68,
                                width: 64,
                                child: TextFormField(
                                  onSaved: (pin) {
                                    pin2 = pin;
                                  },
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    } else {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                )),
                            SizedBox(
                                height: 68,
                                width: 64,
                                child: TextFormField(
                                  onSaved: (pin) {
                                    pin3 = pin;
                                  },
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    } else {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                )),
                            SizedBox(
                                height: 68,
                                width: 64,
                                child: TextFormField(
                                  onSaved: (pin) {
                                    pin4 = pin;
                                  },
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    } else {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                )),
                          ]),
                      SizedBox(height: 10),
                      Text(_pinInvalid ? _pinErr : "",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: RaisedButton(
                              onPressed: () {
                                _formKey.currentState?.save();
                                String pinCode = pin1! + pin2! + pin3! + pin4!;
                                checkPinCode(widget.email, pinCode);
                              },
                              child: Text("Continue",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              color: Colors.blue),
                        ),
                      ),
                    ],
                  )),
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
