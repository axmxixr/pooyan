import 'package:flutter/material.dart';
import 'package:pooyan/Tools/Authentication.dart';
import 'package:pooyan/Tools/Loading.dart';
import 'package:pooyan/Tools/MyColors.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: MyColors.firstBackground,
        appBar: new AppBar(
          backgroundColor: MyColors.appBarAndNavigationBar,
          title: Text("ورود کاربر"),
          centerTitle: true,
        ),
        body: new Form(

          key: _loginFormKey,
          child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Center(
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'این مقدار الزامی است';
                        }
                      },
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.perm_identity,
                            color: Colors.black,
                          ),
                          labelText: "ایمیل"),
                      controller: _userNameController,
                      keyboardAppearance: Brightness.light,
                      keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      focusNode: emailNode,
                        onFieldSubmitted: (term) {
                          emailNode.unfocus();
                          FocusScope.of(context).requestFocus(passwordNode);
                        }

                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'این مقدار الزامی است';
                        }
                      },
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock_outline, color: Colors.black),
                          labelText: "کلمه عبور"),
                      controller: _passwordController,
                      keyboardAppearance: Brightness.light,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      focusNode: passwordNode,

                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          top: 10.0,
                          bottom: 5.0,
                        ),
                        child: Builder(
                            builder: (context) => RaisedButton(
                                textTheme: ButtonTextTheme.primary,
                                elevation: 15.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                onPressed: () {
                                  showLoadingDialog(context);
                                  if (_loginFormKey.currentState.validate()) {
                                    Authentication.login(
                                            context,
                                            _userNameController.text,
                                            _passwordController.text)
                                        .then((val) {
                                      Navigator.pop(context);
                                      if (val) {
                                        Navigator.pushReplacementNamed(
                                            context, "/packages");
                                      } else {
                                        Scaffold.of(context)
                                            .showSnackBar(new SnackBar(
                                          duration: Duration(seconds: 5),
                                          content: new Text(
                                            "مقادیر دارای خطا هستند",
                                            textScaleFactor: 1.5,
                                          ),
                                        ));
                                      }
                                    });
                                  }
                                },
                                child: Text("ورود")))),
                    Padding(
                        padding: EdgeInsets.only(top: 5.0,bottom: 30.0),
                        child: RaisedButton(
                          textTheme: ButtonTextTheme.primary,
                          elevation: 15.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, "/account/register");
                          },
                          child: Text("عضویت جدید"),
                        ))
                  ],
                )),
              )),
        ));
  }
}
