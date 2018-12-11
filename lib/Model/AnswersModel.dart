class AnswersModel {
  final int id;
  final String text;
  final bool isCorrect;
  final int choiceLabel;

  AnswersModel({this.id, this.text, this.isCorrect, this.choiceLabel});

  factory AnswersModel.fromJson(Map<String, dynamic> json) {
    return AnswersModel(
        id: json['Id'],
        text: json['Text'],
        isCorrect: json['IsCorrect'],
        choiceLabel: json['ChoiceLabel']);
  }

  static fromJsonArray(List json) {
    return json.map((i) => AnswersModel.fromJson(i)).toList();
  }

  static const labels = ["الف", "ب", "ج", "د"];

  String textWithLabel() => labels[choiceLabel] + ". " + text;
}
