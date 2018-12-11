class ChallengeModel {
  int id;
  DateTime start;
  DateTime finish;
  String imageUrl;
  String url;

  ChallengeModel({this.id, this.start, this.finish, this.imageUrl, this.url});

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {
    return ChallengeModel(
        id: json['Id'],
        finish: DateTime.parse(json['Finish']),
        start: DateTime.parse(json['Start']),
        imageUrl: json['ImageUrl'],
        url: json['Url']);
  }
}
