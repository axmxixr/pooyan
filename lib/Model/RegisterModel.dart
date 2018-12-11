class RegisterModel {
  final int code;
  final String message;
  final List<dynamic> result;

  RegisterModel({this.code, this.message, this.result});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    final l = (json['Result'] as List<dynamic>);

    return RegisterModel(code: json['Code'], message: json['Message'], result: l);
  }
}
