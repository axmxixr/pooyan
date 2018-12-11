import 'package:flutter/material.dart';
import 'package:pooyan/Pages/AboutUs.dart';
import 'package:pooyan/Pages/BugReportPage.dart';
import 'package:pooyan/Pages/ChangePasswordPage.dart';
import 'package:pooyan/Tools/Authentication.dart';

class ProfileButtons extends StatelessWidget {
  static BuildContext context;
  static String message;

  ProfileButtons(BuildContext c) {
    context = c;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buttonsList = new List();
    buttonsList.add(changePassword);
    buttonsList.add(changeMobileNumber);
    buttonsList.add(aboutUs);
    buttonsList.add(bugReport);
    buttonsList.add(inviteFriends);
    buttonsList.add(signOut);

    return GridView.count(
      padding: EdgeInsets.only(right: 20.0),
      crossAxisCount: 2,
      children: buttonsList,
      childAspectRatio: 3.0,
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 10.0,
    );
  }

  final RaisedButton changePassword = RaisedButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChangePasswordPage()));
      },
      child: Text("تغییر کلمه عبور"),
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)));
  final RaisedButton changeMobileNumber = RaisedButton(
      onPressed: null,
      child: Text("تغییر شماره موبایل"),
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)));
  final RaisedButton aboutUs = RaisedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutUs()));
      },
      child: Text("درباره ما"),
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)));
  final RaisedButton bugReport = RaisedButton(
      onPressed: () {
        Navigator.push(
                context, MaterialPageRoute(builder: (context) => BugReport()))
            .then((c) {
          if (ProfileButtons.message != null) {
            Scaffold.of(context).showSnackBar(new SnackBar(
              content: Text(ProfileButtons.message),
            ));
            ProfileButtons.message = null;
          }
        });
      },
      child: Text("گزارش خرابی"),
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)));
  final RaisedButton inviteFriends = RaisedButton(
      onPressed: null,
      child: Text("دعوت دوستان"),
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)));
  final RaisedButton signOut = RaisedButton(
      onPressed: () {
        Authentication.signOut(context);
      },
      child: Text("خروج"),
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)));
}
