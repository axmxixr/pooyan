import 'package:flutter/material.dart';
import 'package:pooyan/Tools/MyColors.dart';
import 'package:pooyan/Widgets/AvatarSelectorWidget.dart';

class AvatarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: MyColors.firstBackground,
      appBar: AppBar(
        backgroundColor: MyColors.appBarAndNavigationBar,
        title: Text(
          "انتخاب نماد",
          textScaleFactor: 1.4,
          textAlign: TextAlign.center,
        ),
      ),
      body: AvatarSelectorWidget(),
    );
  }
}
