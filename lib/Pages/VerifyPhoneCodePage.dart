import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pooyan/Tools/Authentication.dart';
import 'package:pooyan/Tools/MyColors.dart';

class VerifyPhoneCodePage extends StatefulWidget {
  final String phoneNumber;

  VerifyPhoneCodePage({this.phoneNumber});

  @override
  State<StatefulWidget> createState() => VerifyPhoneCodePageState();
}

class VerifyPhoneCodePageState extends State<VerifyPhoneCodePage> {
  final _verifyCode = GlobalKey<FormState>();
  final _verifyCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _verifyCodeController.addListener(() {
      if (_verifyCodeController.text.length == 6) {
        _submitForm();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Form(
        key: _verifyCode,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "تایید شماره موبایل",
              textScaleFactor: 1.5,
              textAlign: TextAlign.center,
            ),
            backgroundColor: MyColors.appBarAndNavigationBar,
          ),
          backgroundColor: MyColors.firstBackground,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "کد فعال سازی 6 رقمی ارسال شده را وارد کنید و دکمه فعال سازی را لمس کنید",
                textAlign: TextAlign.center,
                textScaleFactor: 1.2,
              ),
              SizedBox(
                  height: 100.0,
                  width: 200.0,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'این مقدار الزامی است';
                      }
                    },
                    controller: _verifyCodeController,
                    maxLength: 6,
                    maxLengthEnforced: true,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(),
                    scrollPadding: EdgeInsets.all(5.0),
                  )),
              Builder(
                  builder: (context) => RaisedButton(
                        onPressed: _submitForm,
                        child: Text("فعال سازی"),
                        elevation: 15.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ))
            ],
          ),
        ));
  }

  void alert(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        content: Text(
          "test",
          textScaleFactor: 1.5,
        )));
  }

  void _submitForm() {
    if (_verifyCode.currentState.validate()) {
      String verifyCode = _verifyCodeController.text;
      Authentication.verifyMobileNumber(context, widget.phoneNumber, verifyCode)
          .then((response) {
        int registerAndLoginStatusCode =
            json.decode(response.body)["Data"]["Code"];
        String registerAndLoginStatusMessage =
            json.decode(response.body)["Data"]["Message"];
        if (registerAndLoginStatusCode == 200) {
          Navigator.pushReplacementNamed(context, "/packages");
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 5),
              content: Text(
                registerAndLoginStatusMessage,
                textScaleFactor: 1.5,
              )));
        }
      });
    }
  }
}
