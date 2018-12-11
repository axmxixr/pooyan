import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pooyan/Tools/Authentication.dart';
import 'package:pooyan/Tools/MyColors.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  final _changePW = GlobalKey<FormState>();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  FocusNode oldPasswordNode = FocusNode();
  FocusNode newPasswordNode = FocusNode();
  FocusNode confirmNewPasswordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            "تغییر رمز عبور",
            textScaleFactor: 1.2,
          ),
          elevation: 15.0,
          centerTitle: true,
          backgroundColor: MyColors.appBarAndNavigationBar,
        ),
        backgroundColor: MyColors.firstBackground,
        body: new Form(
          key: _changePW,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                  obscureText: true,
                controller: oldPassword,
                decoration: InputDecoration(
                    hintText:
                    "حداقل 6 کاراکتر(شامل حروف بزرگ ، کوچک و عدد)",
                    hintStyle: TextStyle(fontSize: 14.0,color: Colors.black),
                    labelText: "رمز عبور قدیمی",
                    prefixIcon: Icon(Icons.lock),
                    contentPadding: EdgeInsets.all(5.0)),
                  keyboardType: TextInputType.text,
                  keyboardAppearance: Brightness.light,
                  textInputAction: TextInputAction.next,
                  focusNode: oldPasswordNode,
                  onFieldSubmitted: (term) {
                    oldPasswordNode.unfocus();
                    FocusScope.of(context).requestFocus(newPasswordNode);
                  }
              ),
              TextFormField(
                  obscureText: true,
                controller: newPassword,
                decoration: InputDecoration(
                    hintText:
                    "حداقل 6 کاراکتر(شامل حروف بزرگ ، کوچک و عدد)",
                    hintStyle: TextStyle(fontSize: 14.0,color: Colors.black),
                    labelText: "رمز عبور جدید",
                    prefixIcon: Icon(Icons.lock_outline),
                    contentPadding: EdgeInsets.all(5.0)),
                  keyboardType: TextInputType.text,
                  keyboardAppearance: Brightness.light,
                  textInputAction: TextInputAction.next,
                  focusNode: newPasswordNode,
                  onFieldSubmitted: (term) {
                    newPasswordNode.unfocus();
                    FocusScope.of(context).requestFocus(confirmNewPasswordNode);
                  }
              ),
              TextFormField(
                obscureText: true,
                controller: confirmNewPassword,
                decoration: InputDecoration(
                    hintText:
                    "حداقل 6 کاراکتر(شامل حروف بزرگ ، کوچک و عدد)",
                    hintStyle: TextStyle(fontSize: 14.0,color: Colors.black),
                    labelText: "تکرار رمز عبور جدید",
                    prefixIcon: Icon(Icons.lock_outline),
                    contentPadding: EdgeInsets.all(5.0)),
                  keyboardType: TextInputType.text,
                  keyboardAppearance: Brightness.light,
                  textInputAction: TextInputAction.done,
                  focusNode: confirmNewPasswordNode,
              ),
              Builder(
                  builder: (context) => Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      child: RaisedButton(
                        onPressed: () {
                          if (_changePW.currentState.validate()) {
                            Authentication.changePassword(
                                    context,
                                    oldPassword.text,
                                    newPassword.text,
                                    confirmNewPassword.text)
                                .then((response) {
                              int changePasswordStatusCode =
                                  json.decode(response.body)["Data"]["Code"];
                              String changePasswordStatusMessage =
                                  json.decode(response.body)["Data"]["Message"];
                              if (changePasswordStatusCode == 200) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    duration: Duration(seconds: 5),
                                    content: Text(
                                      "تغییر رمز با موفقیت انجام شد",
                                      textScaleFactor: 1.5,
                                    )));
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    duration: Duration(seconds: 5),
                                    content: Text(
                                      changePasswordStatusMessage,
                                      textScaleFactor: 1.5,
                                    )));
                              }
                            });
                          }
                        },
                        child: Text("تغییر رمز"),
                        elevation: 15.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ))),
              Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/packages");
                    },
                    child: Text("بازگشت به صفحه اصلی"),
                    elevation: 15.0,
                    padding: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ))
            ],
          ),
        ));
  }
}
