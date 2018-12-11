
class LeaderBoardItem {
  int order;
  String name;
  int score;

  LeaderBoardItem({this.name, this.order, this.score});

  factory LeaderBoardItem.fromJson(Map<String, dynamic> json) {
    return LeaderBoardItem(
        order: json['Order'], name: json['Name'], score: json['Score']);
  }

  static fromJsonArray(List json) {
    return json.map((i) => LeaderBoardItem.fromJson(i)).toList();
  }


}
