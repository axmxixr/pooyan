import 'dart:async';

import 'package:flutter/material.dart';

Future<Null> showLoadingDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (ctx) {
        return new FlatButton(onPressed: null, child: CircularProgressIndicator(strokeWidth: 5.0,));

      });

  return;
}
