import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:pooyan/Tools/ConstValues.dart';

enum helpPages {
  selectedPackage,
  profilePage,
  packagesPage,
  myPackages,
  learningPage,
  examiningPage,
  challengePage,
  categoryPage
}

class Help extends StatefulWidget {
  final helpPages helpPageName;

  Help({this.helpPageName});

  @override
  State<StatefulWidget> createState() => HelpState();
}

class HelpState extends State<Help> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(primary: true,
      url: Values.Host + "helppage/" + widget.helpPageName.toString().split(".")[1],
    );
  }
}
