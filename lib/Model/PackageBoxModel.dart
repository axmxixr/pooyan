import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pooyan/Tools/Authentication.dart';
import 'package:pooyan/Tools/ConstValues.dart';

class PackageBoxModel {
  final int id;
  final int userPackageBoxId;
  final int packageId;
  final int code;
  final int boxState;
  final int stateValue;
  final String title;

  PackageBoxModel({
    this.id,
    this.userPackageBoxId,
    this.packageId,
    this.code,
    this.boxState,
    this.stateValue,
    this.title,
  });

  factory PackageBoxModel.fromJson(Map<String, dynamic> json) {
    return PackageBoxModel(
      title: json['Title'],
      stateValue: json['StateValue'],
      boxState: json['BoxState'],
      code: json['Code'],
      packageId: json['PackageId'],
      userPackageBoxId: json['UserPackageBoxId'],
      id: json['Id'],
    );
  }

  static fromJsonArray(List json) {
    return json.map((i) => PackageBoxModel.fromJson(i)).toList();
  }

  Icon getBoxIcon() {
    int boxStateIcon = boxState;
    switch (boxStateIcon) {
      case 0:
        return new Icon(Icons.not_interested);
      case 1:
        return new Icon(Icons.cloud_upload);
      case 2:
        return new Icon(Icons.done);
      case 3:
        return new Icon(Icons.done_all);
      default:
        return null;
    }
  }
}

Future<List<PackageBoxModel>> getPackageBox(
    BuildContext context, int id) async {
  final header = await Authentication.getHeader(context);
  Map<String, String> x = {"id": id.toString()};
  List<PackageBoxModel> packageBoxData = new List<PackageBoxModel>();
  final response = await http.post(
      Values.Host + "api/packages/UserPackageBoxes",
      body: x,
      headers: header);
  packageBoxData = PackageBoxModel.fromJsonArray(
      json.decode(response.body)["Data"]["Result"]);
  return packageBoxData;
}
