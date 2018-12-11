import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pooyan/Tools/Authentication.dart';
import 'package:pooyan/Tools/ConstValues.dart';

import 'AnswersModel.dart';

class QuestionsModel {
  final int id;
  final String questionText;
  final int correctAnswer;
  final String answerText;
  int userAnswerId;
  final String hint;
  final List<AnswersModel> answersModel;

  QuestionsModel(
      {this.id,
      this.questionText,
      this.correctAnswer,
      this.answerText,
      this.hint,
      this.userAnswerId,
      this.answersModel});

  factory QuestionsModel.fromJson(Map<String, dynamic> json) {
    return QuestionsModel(
        id: json['Id'],
        questionText: json['QuestionText'],
        correctAnswer: json['CorrextAnswer'],
        answerText: json['AnswerText'],
        hint: json['Hint'],
        userAnswerId: json['UserAnswerId'],
        answersModel: AnswersModel.fromJsonArray(json['Answers']));
  }

  static fromJsonArray(List json) {
    return json.map((i) => QuestionsModel.fromJson(i)).toList();
  }
}

Future<List<QuestionsModel>> getQuestions(
    BuildContext context, int userPackageBoxId) async {
  final header = await Authentication.getHeader(context);
  Map<String, String> x = {"id": userPackageBoxId.toString()};
  List<QuestionsModel> questions = new List<QuestionsModel>();
  final response = await http.post(Values.Host + "api/boxes/UserBoxQuestions",
      body: x, headers: header);
  questions = QuestionsModel.fromJsonArray(
      json.decode(response.body)["Data"]["Result"]);
  return questions;
}

Future<Null> answerQuestion(BuildContext context, int answerId) async {
  final header = await Authentication.getHeader(context);
  Map<String, String> x = {"AnswerId": answerId.toString()};
  await http.post(Values.Host + "api/learning/AnsweringArticle",
      body: x, headers: header);
}

Future<Null> questionViewed(
    BuildContext context, int questionId, int boxId) async {
  final header = await Authentication.getHeader(context);
  Map<String, String> x = {
    "QuestionId": questionId.toString(),
    "BoxId": boxId.toString()
  };
  await http.post(Values.Host + "api/learning/QuestionViewed",
      body: x, headers: header);
}
