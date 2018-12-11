import 'package:flutter/widgets.dart';
import 'package:pooyan/Widgets/TextWithHeaderWidget.dart';

class TimeSpanWidget extends StatelessWidget {
  final DateTime dateTime;

  TimeSpanWidget({this.dateTime});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime3 = dateTime;
    DateTime now = DateTime.now();
    Duration duration = dateTime3.difference(now);
    List<Widget> times = new List();

    if (duration.inDays > 0) {
      times.add(TextWithHeader(title: "روز", value: duration.inDays));
      dateTime3 = dateTime3.add(Duration(days: duration.inDays * -1));
      duration = dateTime3.difference(now);
    }
    if (duration.inHours > 0 || times.length > 0) {
      times.add(TextWithHeader(
        title: "ساعت",
        value: duration.inHours,
      ));
      dateTime3 = dateTime3.add(Duration(hours: duration.inHours * -1));
      duration = dateTime3.difference(now);
    }
    if (duration.inMinutes > 0 || times.length > 0) {
      times.add(TextWithHeader(
        title: "دقیقه",
        value: duration.inMinutes,
      ));
      dateTime3 = dateTime3.add(Duration(minutes: duration.inMinutes * -1));
      duration = dateTime3.difference(now);
    }
    if (duration.inSeconds > 0 || times.length > 0) {
      times.add(TextWithHeader(
        title: "ثانیه",
        value: duration.inSeconds,
      ));
    }

    return Row(
      children: times.reversed.toList(),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}
