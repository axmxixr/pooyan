import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pooyan/Pages/CategoryPage.dart';
import 'package:pooyan/Pages/ChallengePage.dart';
import 'package:pooyan/Pages/MyPackages.dart';
import 'package:pooyan/Pages/ProfilePage.dart';
import 'package:pooyan/Pages/SearchPage.dart';
import 'package:pooyan/Tools/Authentication.dart';

Future<Widget> dispatch(pages page, BuildContext context) async {
  bool b = await Authentication.read(context);
  if (!b) return null;
  switch (page) {
    case pages.buy:
      return CategoryPage();
    case pages.challenge:
      return ChallengePage();
    case pages.packages:
      return new MyPackages();
    case pages.search:
      return SearchPage();
    case pages.profile:
      return ProfilePage();
    case pages.login:
      return Text("Login");
    case pages.register:
      return Text("register");
  }
  return Text("nothing");
}

enum pages { buy, challenge, packages, search, profile, login, register }