import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pooyan/Model/TokenModel.dart';
import 'package:pooyan/Tools/ConstValues.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  static SharedPreferences _prefs;
  static String at;
  static String rt;
  static bool firstTime = true;

  static Future<bool> login(
      BuildContext context, String username, String password) async {
    Map<String, String> b = {
      "grant_type": "password",
      "username": username,
      "password": password
    };

    final response = await http.post(Values.Host + "token", body: b);

    if (response.statusCode == 200) {
      if (_prefs == null) _prefs = await SharedPreferences.getInstance();
      final atByRt = TokenModel.fromJson(json.decode(response.body));
      at = atByRt.accessToken;
      rt = atByRt.refreshToken;
      _prefs.setString("at", at);
      _prefs.setString("rt", rt);
      return true;
    }
    return false;
  }

  static Future<bool> read(BuildContext context) async {
    if (at == null) {
      if (_prefs == null) {
        _prefs = await SharedPreferences.getInstance();
      }
      at = _prefs.getString("at");
      rt = _prefs.getString("rt");
      if (at == null) {
        if (rt == null) {
          Navigator.pushReplacementNamed(context, "/account/introSlides");

          return false;
        } else {
          Map<String, String> b = {
            "grant_type": "refresh_token",
            "clientid": "self",
            "refresh_token": rt
          };

          final response = await http.post(Values.Host + "token", body: b);
          final atByRt = TokenModel.fromJson(json.decode(response.body));
          at = atByRt.accessToken;
          _prefs.setString("at", at);
        }
      } else if (firstTime) {
        firstTime = false;
        Map<String, String> b = {
          "grant_type": "refresh_token",
          "clientid": "self",
          "refresh_token": rt
        };

        final response = await http.post(Values.Host + "token", body: b);
        final atByRt = TokenModel.fromJson(json.decode(response.body));
        at = atByRt.accessToken;
        _prefs.setString("at", at);
      } else {
        //todo: call test api to validate
      }
    }
    return true;
  }

  static Future<Map<String, String>> getHeader(BuildContext context) async {
    if (await read(context)) {
      Map<String, String> b = {"Authorization": "bearer " + at};
      return b;
    } else
      return null;
  }

  static Future<http.Response> register(
      BuildContext context,
      String firstName,
      String lastName,
      String mobileNumber,
      String email,
      String password,
      String confirmPassword,
      String presenterCode) async {
    Map<String, String> x = {
      "FirstName": firstName,
      "LastName": lastName,
      "Mobile": mobileNumber,
      "Email": email,
      "Password": password,
      "ConfirmPassword": confirmPassword,
      "PresenterCode": presenterCode
    };

    final response =
        await http.post(Values.Host + "api/account/register", body: x);
    return response;
  }

  static Future<http.Response> registerAndLogin(
      BuildContext context,
      String firstName,
      String lastName,
      String mobileNumber,
      String email,
      String password,
      String confirmPassword,
      String presenterCode) async {
    final response = await register(context, firstName, lastName, mobileNumber,
        email, password, confirmPassword,presenterCode);
    int registerAndLoginStatusCode = json.decode(response.body)["Data"]["Code"];
    if (registerAndLoginStatusCode == 200) {
      await login(context, email, password);
    }

    return response;
  }

  static Future signOut(BuildContext context) async {
    at = rt = null;
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
    _prefs.setString("at", at);
    _prefs.setString("rt", rt);
    Navigator.pushReplacementNamed(context, "/account/login");
  }

  static Future<http.Response> verifyMobileNumber(
      BuildContext context, String phoneNumber, String verifyCode) async {
    final header = await Authentication.getHeader(context);
    Map<String, String> x = {"PhoneNumber": phoneNumber, "Code": verifyCode};
    final response = await http.post(
        Values.Host + "api/account/VerifyPhoneCode",
        body: x,
        headers: header);

    return response;
  }

  static Future<http.Response> changePassword(BuildContext context,
      String oldPassword, String newPassword, String confirmNewPassword) async {
    final header = await Authentication.getHeader(context);
    Map<String, String> x = {
      "OldPassword": oldPassword,
      "NewPassword": newPassword,
      "ConfirmPassword": confirmNewPassword
    };
    final response = await http.post(Values.Host + "api/account/ChangePassword",
        body: x, headers: header);

    return response;
  }
}
