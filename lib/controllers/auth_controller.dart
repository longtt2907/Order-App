import 'dart:convert';

import 'package:demo_12_03/constants.dart';
import 'package:http/http.dart';

class AuthService {
  final String authUrl = "$BASE_URL/auth";

  Future<bool> register(
      String? email, String? fullName, String? phoneNumber) async {
    Response res = await post(Uri.parse("$authUrl/register"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email": email,
          "fullName": fullName,
          "phoneNumber": phoneNumber,
        }));

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      bool isSuccess = body['isSuccess'];
      return isSuccess;
    } else {
      return false;
    }
  }

  Future<bool> checkEmail(String email) async {
    Response res = await post(Uri.parse("$authUrl/check-email"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"email": email}));

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      bool isSuccess = body['isSuccess'];
      return isSuccess;
    }
    return false;
  }

  Future<bool> checkPinCode(String email, String pinCode) async {
    Response res = await post(Uri.parse("$authUrl/check-pin"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"email": email, "pin": pinCode}));

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      bool isSuccess = body["isSuccess"];
      return isSuccess;
    } else {
      return false;
    }
  }

  Future<bool> recoverPassword(
      String email, String pin, String password) async {
    Response res = await post(Uri.parse("$authUrl/recover-password"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email": email,
          "pin": pin,
          "password": password,
        }));

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      bool isSuccess = body["isSuccess"];
      return isSuccess;
    } else {
      return false;
    }
  }

  Future<String> login(String email, String password) async {
    Response res = await post(Uri.parse("$authUrl/login"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }));

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      return body;
    } else {
      return "";
    }
  }
}
