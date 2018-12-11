class ExternalArticleModel {
  final int id;
  final String title;
  final String url;

  ExternalArticleModel({this.id,
    this.title,
    this.url,
  });

  factory ExternalArticleModel.fromJson(Map<String, dynamic> json) {
    return ExternalArticleModel(
      title:  json['Title'],
      id:  json['Id'],
      url:  json['Url'],
    );
  }
  static fromJsonArray(List json) {
    return json.map((i)=>ExternalArticleModel.fromJson(i)).toList();
  }
}