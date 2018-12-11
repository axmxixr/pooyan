import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pooyan/Tools/Authentication.dart';
import 'package:pooyan/Tools/ConstValues.dart';

class AvatarModel {
  String image;
  int id;
  static AvatarModel currentUser = new AvatarModel();

  AvatarModel({this.id, this.image});

  factory AvatarModel.fromJson(Map<String, dynamic> json) {
    return AvatarModel(
      id: json['Id'],
      image: json['Image'],
    );
  }

  static fromJsonArray(List json) {
    return json.map((i) => AvatarModel.fromJson(i)).toList();
  }
}

Future avatarSet(BuildContext context, int avatarId) async {
  final header = await Authentication.getHeader(context);
  await http.post(Values.Host + "api/profile/SetAvatar",
      headers: header, body: {"Id": avatarId.toString()});
}

Future setAvatarImage(BuildContext context, AvatarModel model) async {
  AvatarModel.currentUser = model;
  await avatarSet(context, model.id);
}

Future<List<AvatarModel>> getAvatars(BuildContext context) async {
  final header = await Authentication.getHeader(context);
  List<AvatarModel> avatarData = new List<AvatarModel>();
  final response = await http
      .post(Values.Host + "api/profile/ProfileImagesList", headers: header);
  avatarData =
      AvatarModel.fromJsonArray(json.decode(response.body)["Data"]["Result"]);
  return avatarData;
}
