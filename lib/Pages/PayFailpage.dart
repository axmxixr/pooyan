import 'package:flutter/material.dart';
import 'package:pooyan/Tools/MyColors.dart';

class PayFailPage extends StatelessWidget {
  final String traceNumber;

  PayFailPage({this.traceNumber});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "پرداخت نا موفق",
          textScaleFactor: 1.2,
          textAlign: TextAlign.center,
        ),
        backgroundColor: MyColors.appBarAndNavigationBar,
      ),
      backgroundColor: MyColors.firstBackground,
      body: Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "پرداخت ناموفق",
                textScaleFactor: 1.5,
                textAlign: TextAlign.center,
              ),
              Text("شماره رهگیری" + traceNumber)
            ],
          ),
        ),
      ),
    );
  }
}
