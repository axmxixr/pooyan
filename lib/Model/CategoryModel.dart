class CategoryModel {
  final int id;
  final String title;
  final String description;
  final String absoluteImageUrl;

  CategoryModel({this.id,
    this.title,
    this.description,
    this.absoluteImageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      title:  json['Title'],
      id:  json['Id'],
      description:  json['Description'],
      absoluteImageUrl:  json['AbsoluteImageUrl'],
    );
  }
  static fromJsonArray(List json) {
    return json.map((i)=>CategoryModel.fromJson(i)).toList();
  }
}