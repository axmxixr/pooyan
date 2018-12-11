import 'package:flutter/widgets.dart';
import 'package:pooyan/Tools/MyColors.dart';

class TextWithHeader extends StatelessWidget {
  final String title;
  final int value;

  TextWithHeader({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      child: SizedBox(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[Text(title), Text(value.toString())],
            )),
        width: 60.0,
      ),
      decoration: BoxDecoration(
          border: Border.all(color: MyColors.borders, width: 2.0),
          shape: BoxShape.circle),
    );
  }
}
