import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pooyan/Tools/Authentication.dart';
import 'package:pooyan/Tools/ConstValues.dart';

class PackageModel {
  final int id;
  final int categoryId;
  final String title;
  final String imageUrl;
  final String coverUrl;
  String description;
  final int userPackageId;
  final int userPackageState;

  PackageModel(
      {this.categoryId,
      this.coverUrl,
      this.description,
      this.id,
      this.imageUrl,
      this.title,
      this.userPackageId,
      this.userPackageState});

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      title: json['Title'],
      categoryId: json['CategoryId'],
      coverUrl: json['CoverUrl'],
      description: json['Description'],
      id: json['Id'],
      imageUrl: json['ImageUrl'],
      userPackageId: json['UserPackageId'],
      userPackageState: json['UserPackageState'],
    );
  }

  static fromJsonArray(List json) {
    return json.map((i) => PackageModel.fromJson(i)).toList();
  }

  Icon getIcon() {
    int packageState = userPackageState;
    switch (packageState) {
      case 1:
        return new Icon(Icons.sim_card, color: Colors.black);
      case 2:
        return new Icon(Icons.shopping_basket, color: Colors.black);
      case 3:
        return new Icon(Icons.check, color: Colors.black);
      case 4:
        return new Icon(Icons.check_box, color: Colors.black);
      default:return new Icon(
        Icons.error,
        color: Colors.black,
      );
    }
  }
}

Future<List<PackageModel>> getPackages(BuildContext context, int id) async {
  final header = await Authentication.getHeader(context);
  Map<String, String> x = {"id": id.toString()};
  List<PackageModel> packageData = new List<PackageModel>();
  final response = await http.post(Values.Host + "api/packages/packages",
      body: x, headers: header);
  packageData =
      PackageModel.fromJsonArray(json.decode(response.body)["Data"]["Result"]);
  return packageData;
}

Future<List<PackageModel>> getMyPackages(BuildContext context) async {
  final header = await Authentication.getHeader(context);
  List<PackageModel> myPackageData = new List<PackageModel>();
  final response = await http.post(Values.Host + "api/packages/mypackages2",
      headers: header);
  myPackageData =
      PackageModel.fromJsonArray(json.decode(response.body)["Data"]["Result"]);
  return myPackageData;
}

Future<String> moneyRequest(BuildContext context, int packageId) async {
  final header = await Authentication.getHeader(context);
  Map<String, String> x = {"id": packageId.toString()};
  final response = await http.post(
      Values.Host + "api/packages/GetPackageTransactionKey",
      body: x,
      headers: header);
  String moneyUrl = json.decode(response.body)["Data"]["Result"]["ReferUrl"];
  return moneyUrl;
}

Future boughtPackage(BuildContext context, String boughtPackageId) async {
  final header = await Authentication.getHeader(context);
  Map<String, String> x = {"Id": boughtPackageId};
  final response = await http.post(Values.Host + "api/Packages/PackageById",
      body: x, headers: header);

  PackageModel boughtPackageData =
      PackageModel.fromJson(json.decode(response.body)["Data"]["Result"]);
  return boughtPackageData;
}
