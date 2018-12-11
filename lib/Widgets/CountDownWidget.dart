import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:pooyan/Widgets/TimeSpanWidget.dart';

class CountDownWidget extends StatefulWidget {
  final DateTime dateTime;

  CountDownWidget({this.dateTime});

  @override
  State<StatefulWidget> createState() => CountDownWidgetState();
}

class CountDownWidgetState extends State<CountDownWidget> {
  Timer t;
  TimeSpanWidget timeSpanWidget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: timeSpanWidget,
    );
  }

  @override
  void initState() {
    super.initState();
    t = Timer.periodic(Duration(seconds: 1), ticked);
  }

  void ticked(Timer t) {
    if (widget.dateTime.isBefore(DateTime.now())) {
      return;
    }
    setState(() {
      timeSpanWidget = TimeSpanWidget(dateTime: widget.dateTime);
    });
  }
}
