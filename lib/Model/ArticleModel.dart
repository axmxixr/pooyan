import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pooyan/Model/ExternalArticleModel.dart';
import 'package:pooyan/Tools/Authentication.dart';
import 'package:pooyan/Tools/ConstValues.dart';

class ArticleModel {
  final int id;
  final String title;
  final String imageUrl;
  final int order;
  final List<ExternalArticleModel> externalArticles;

  ArticleModel(
      {this.id, this.title, this.imageUrl, this.order, this.externalArticles});

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
        title: json['Title'],
        id: json['Id'],
        imageUrl: json['ImageUrl'],
        order: json['Order'],
        externalArticles:
            ExternalArticleModel.fromJsonArray(json['ExternalArticles']));
  }

  static fromJsonArray(List json) {
    return json.map((i) => ArticleModel.fromJson(i)).toList();
  }

  void articleLearned(BuildContext context, int boxId) {
    learningArticle(context, boxId, order);
  }
}

Future<List<ArticleModel>> getBoxArticles(
    BuildContext context, int userPackageBoxId) async {
  final header = await Authentication.getHeader(context);
  Map<String, String> x = {"id": userPackageBoxId.toString()};
  List<ArticleModel> articles = new List<ArticleModel>();
  final response = await http.post(Values.Host + "api/boxes/UserBoxArticles",
      body: x, headers: header);
  articles =
      ArticleModel.fromJsonArray(json.decode(response.body)["Data"]["Result"]);
  return articles;
}

Future learningArticle(BuildContext context, int boxId, int order) async {
  final header = await Authentication.getHeader(context);
  Map<String, String> x = {
    "BoxId": boxId.toString(),
    "Order": order.toString()
  };
  await http.post(Values.Host + "api/learning/LearnedArticle",
      body: x, headers: header);
}
