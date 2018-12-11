import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:pooyan/Model/PackageModel.dart';
import 'package:pooyan/Pages/PayFailpage.dart';
import 'package:pooyan/Tools/Loading.dart';
import 'package:pooyan/Tools/MyColors.dart';

class MoneyPage extends StatefulWidget {
  final int packageId;

  MoneyPage({this.packageId});

  @override
  State<StatefulWidget> createState() => MoneyPageState();
}

class MoneyPageState extends State<MoneyPage> {
  String traceNumber;
  int packageId;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: MyColors.firstBackground,
      appBar: AppBar(
          backgroundColor: MyColors.appBarAndNavigationBar,
          title: Text(
            "خرید",
            textScaleFactor: 1.6,
            textAlign: TextAlign.center,
          )),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: () {
                    showLoadingDialog(context);
                    moneyRequest(context, widget.packageId).then((bankUrl) {
                      Navigator.pop(context);
                      flutterWebviewPlugin.launch(
                        bankUrl,
                        enableAppScheme: true,
                      );
                    });
                  },
                  child:
                      Text("خرید آنلاین (درگاه بانکی)", textScaleFactor: 1.5),
                  padding: EdgeInsets.all(5.0),
                  elevation: 15.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                )),
            Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "خرید نقدی بسته از طریق درگاه بانکی . با استفاده از این روش کل بسته به صورت نقدی خریداری شده و در اختیار شما قرار می گیرد.",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.3,
                )),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: null,
                elevation: 15.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Text(
                  "خرید وس (VAS)",
                  textScaleFactor: 1.5,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "خرید سرویس ارزش افزوده . با استفاده از این روش روزانه مبلغ 5000 ریال ار حساب شما کسر شده و یک جعبه مطلب جدید در اختیار شما قرار می گیرد.",
                  textScaleFactor: 1.3,
                ))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onUrlChanged.listen((payUrl) {
      if (payUrl.startsWith("http://mohsenmeshkini.ir/mobile/fail")) {
        flutterWebviewPlugin.close();
        int x = payUrl.lastIndexOf("/");
        traceNumber = payUrl.substring(x + 1);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PayFailPage(
                    traceNumber: traceNumber,
                  )),
        );
      }
      if (payUrl.startsWith("http://mohsenmeshkini.ir/mobile/success")) {
        flutterWebviewPlugin.close();
        Navigator.pop(context);
        //int y = payUrl.lastIndexOf("/");
        //String boughtPackageId = payUrl.substring(y+1);
//        boughtPackage(context, boughtPackageId).then((boughtPackageData) {
//          Navigator.pushReplacement(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => SelectedPackage(
//                        package: boughtPackageData,
//                      )));
//        });
      }
    });
  }
}
