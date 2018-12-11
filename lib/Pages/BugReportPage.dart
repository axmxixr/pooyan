import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pooyan/Tools/Authentication.dart';
import 'package:pooyan/Tools/ConstValues.dart';
import 'package:pooyan/Tools/MyColors.dart';
import 'package:pooyan/Widgets/ProfileButtonsWidget.dart';

class BugReport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BugReportState();
}

class BugReportState extends State<BugReport> {
  final _loginFormKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: MyColors.firstBackground,
      appBar: AppBar(
        backgroundColor: MyColors.appBarAndNavigationBar,
        centerTitle: true,
        title: Text("گزارش خرابی"),
      ),
      body: Form(
          key: _loginFormKey,
          child: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                SizedBox.fromSize(
                    size: Size(400.0, 200.0),
                    child: TextField(
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      controller: _userNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          contentPadding: EdgeInsets.all(10.0),
                          hintText:
                              "با تشکر از همکاری شما . پس از وارد کردن\n اطلاعات مربوط به خرابی دکمه ثبت را لمس کنید"),
                      textAlign: TextAlign.start,
                    )),
                Center(
                    child: RaisedButton(
                  onPressed: () {
                    sendBugReport(context, _userNameController.text);
                    ProfileButtons.message =
                        "از اینکه در توسعه این برنامه سهیم شده اید از شما ممنونیم";
                    Navigator.pop(context);
                  },
                  child: Text("ثبت"),
                  elevation: 15.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  padding: EdgeInsets.all(10.0),
                ))
              ]))),
    );
  }
}

Future sendBugReport(BuildContext context, String bug) async {
  final header = await Authentication.getHeader(context);
  Map<String, String> x = {"Bug": bug};
  await http.post(Values.Host + "api/Profile/BugReport",
      body: x, headers: header);
}
