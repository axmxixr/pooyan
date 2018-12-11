import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pooyan/Pages/LoginPage.dart';
import 'package:pooyan/Pages/VerifyPhoneCodePage.dart';
import 'package:pooyan/Tools/Authentication.dart';
import 'package:pooyan/Tools/Loading.dart';
import 'package:pooyan/Tools/MyColors.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  bool phoneVerified = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController presenterCode = TextEditingController();
  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode mobileNumberNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  FocusNode presenterCodeNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    Scaffold s = Scaffold(
        backgroundColor: MyColors.firstBackground,
        appBar: new AppBar(
          backgroundColor: MyColors.appBarAndNavigationBar,
          title: new Text(
            "نرمافزار مطلب",
            textScaleFactor: 1.2,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidate: true,
                child: Center(
                  child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(children: <Widget>[
                        TextFormField(
                            controller: firstName,
                            decoration: InputDecoration(
                                hintText: "نام",
                                prefixIcon: Icon(
                                  Icons.perm_identity,
                                  color: Colors.black,
                                ),
                                contentPadding: EdgeInsets.all(5.0)),
                            keyboardType: TextInputType.text,
                            keyboardAppearance: Brightness.light,
                            textInputAction: TextInputAction.next,
                            focusNode: firstNameNode,
                            onFieldSubmitted: (term) {
                              firstNameNode.unfocus();
                              FocusScope.of(context).requestFocus(lastNameNode);
                            }),
                        TextFormField(
                            controller: lastName,
                            decoration: InputDecoration(
                                hintText: "نام خانوادگی",
                                prefixIcon: Icon(Icons.perm_identity,
                                    color: Colors.black),
                                contentPadding: EdgeInsets.all(5.0)),
                            keyboardType: TextInputType.text,
                            keyboardAppearance: Brightness.light,
                            textInputAction: TextInputAction.next,
                            focusNode: lastNameNode,
                            onFieldSubmitted: (term) {
                              lastNameNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(mobileNumberNode);
                            }),
                        TextFormField(
                            controller: mobileNumber,
                            decoration: InputDecoration(
                                hintText: "شماره موبایل",
                                prefixIcon:
                                    Icon(Icons.call, color: Colors.black),
                                contentPadding: EdgeInsets.all(5.0)),
                            keyboardType: TextInputType.phone,
                            keyboardAppearance: Brightness.light,
                            textInputAction: TextInputAction.next,
                            focusNode: mobileNumberNode,
                            validator: (String validMobileNo) {
                              validMobileNo = mobileNumber.text;
                              String mobileNoRegEx = r'(\+\d{1,3}[- ]?)?\d{10}';
                              RegExp mobileNoRegExp = new RegExp(mobileNoRegEx);
                              if (!mobileNoRegExp.hasMatch(validMobileNo)) {
                                return "شماره موبایل وارد شده صحیح نیست";
                              } else {
                                return null;
                              }
                            },
                            onFieldSubmitted: (term) {
                              _validateInputs();
                              mobileNumberNode.unfocus();
                              FocusScope.of(context).requestFocus(emailNode);
                            }),
                        TextFormField(
                            validator: (String validEmail) {
                              validEmail = email.text;
                              String emailRegEx =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp emailRegExp = new RegExp(emailRegEx);
                              if (!emailRegExp.hasMatch(validEmail)) {
                                return "ایمیل وارد شده اشتباه است";
                              } else {
                                return null;
                              }
                            },
                            controller: email,
                            decoration: InputDecoration(
                                hintText: "ایمیل",
                                prefixIcon: Icon(Icons.accessibility,
                                    color: Colors.black),
                                contentPadding: EdgeInsets.all(5.0)),
                            keyboardType: TextInputType.emailAddress,
                            keyboardAppearance: Brightness.light,
                            textAlign: TextAlign.start,
                            textInputAction: TextInputAction.next,
                            focusNode: emailNode,
                            onFieldSubmitted: (term) {
                              _validateInputs();
                              emailNode.unfocus();
                              FocusScope.of(context).requestFocus(passwordNode);
                            }),
                        TextFormField(
                            obscureText: true,
                            controller: password,
                            decoration: InputDecoration(
                                hintText:
                                    "حداقل 6 کاراکتر(شامل حروف بزرگ ، کوچک و عدد)",
                                hintStyle: TextStyle(
                                    fontSize: 14.0, color: Colors.black),
                                labelText: "رمز عبور",
                                prefixIcon:
                                    Icon(Icons.vpn_key, color: Colors.black),
                                contentPadding: EdgeInsets.all(5.0)),
                            keyboardType: TextInputType.text,
                            keyboardAppearance: Brightness.light,
                            textInputAction: TextInputAction.next,
                            focusNode: passwordNode,
                            validator: (String validPassword) {
                              validPassword = password.text;
                              String lowerPasswordRegEx = r'.*[a-z].*';
                              String upperPasswordRegEx = r'.*[A-Z].*';
                              String noPasswordRegEx = r'.*\d.*';
                              RegExp lowerPasswordRegExp =
                                  new RegExp(lowerPasswordRegEx);
                              RegExp upperPasswordRegExp =
                                  new RegExp(upperPasswordRegEx);
                              RegExp noPasswordRegExp =
                                  new RegExp(noPasswordRegEx);
                              if (validPassword.length < 6) {
                                return "رمز عبور باید حداقل 6 کاراکتر داشته باشد";
                              }
                              if (!lowerPasswordRegExp
                                  .hasMatch(validPassword)) {
                                return "رمز عبور حداقل باید شامل یک حرف کوچک باشد";
                              }
                              if (!upperPasswordRegExp
                                  .hasMatch(validPassword)) {
                                return "رمز عبور حداقل باید شامل یک حرف بزرگ باشد";
                              }
                              if (!noPasswordRegExp.hasMatch(validPassword)) {
                                return "رمز عبور حداقل باید شامل یک عدد باشد";
                              } else {
                                return null;
                              }
                            },
                            onFieldSubmitted: (term) {
                              _validateInputs();
                              passwordNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(confirmPasswordNode);
                            }),
                        TextFormField(
                            obscureText: true,
                            controller: confirmPassword,
                            decoration: InputDecoration(
                                hintText: "تکرار رمز عبور",
                                prefixIcon:
                                    Icon(Icons.vpn_key, color: Colors.black),
                                contentPadding: EdgeInsets.all(5.0)),
                            keyboardType: TextInputType.text,
                            keyboardAppearance: Brightness.light,
                            textInputAction: TextInputAction.next,
                            focusNode: confirmPasswordNode,
                            validator: (dynamic) {
                              String validPassword = password.text;
                              String validConfirmPassword = confirmPassword.text;
                              if (validPassword != validConfirmPassword){
                                return "رمز عبور و تکرار رمز عبور مطابقت ندارند";
                              }
                              else {
                                return null;
                              }
                            },
                            onFieldSubmitted: (term) {
                              _validateInputs();
                              confirmPasswordNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(presenterCodeNode);
                            }),
                        TextFormField(
                          obscureText: true,
                          controller: presenterCode,
                          decoration: InputDecoration(
                              hintText: "کد معرف (اختیاری)",
                              prefixIcon: Icon(Icons.assignment_ind,
                                  color: Colors.black),
                              contentPadding: EdgeInsets.all(5.0)),
                          keyboardType: TextInputType.number,
                          keyboardAppearance: Brightness.light,
                          focusNode: presenterCodeNode,
                        ),
                        Builder(
                            builder: (context) => Padding(
                                padding:
                                    EdgeInsets.only(top: 15.0, bottom: 5.0),
                                child: RaisedButton(
                                  onPressed: () {
                                    _validateInputs();
                                    showLoadingDialog(context);
                                    Authentication.registerAndLogin(
                                            context,
                                            firstName.text,
                                            lastName.text,
                                            mobileNumber.text,
                                            email.text,
                                            password.text,
                                            confirmPassword.text,
                                            presenterCode.text)
                                        .then((response) {
                                      Navigator.pop(context);
                                      int verifyStatusCode =
                                          json.decode(response.body)["Data"]
                                              ["Code"];
                                      String verifyStatusMessage =
                                          json.decode(response.body)["Data"]
                                              ["Message"];
                                      if (verifyStatusCode == 200) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context2) =>
                                                    VerifyPhoneCodePage(
                                                        phoneNumber:
                                                            mobileNumber
                                                                .text)));
                                      } else {
                                        Scaffold.of(context)
                                            .showSnackBar(new SnackBar(
                                          duration: Duration(seconds: 5),
                                          content: new Text(
                                            verifyStatusMessage,
                                            textScaleFactor: 1.5,
                                          ),
                                        ));
                                      }
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  padding: EdgeInsets.all(10.0),
                                  elevation: 15.0,
                                  child: Text("ثبت نام"),
                                ))),
                        Padding(
                            padding: EdgeInsets.only(top: 5.0, bottom: 30.0),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: Text("عضو هستم"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              elevation: 15.0,
                              padding: EdgeInsets.all(10.0),
                            ))
                      ])),
                ))));
    return s;
  }
}
