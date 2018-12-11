class TokenModel {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;
  final String userName;
  final String issued;
  final String expires;

  TokenModel(
      {this.accessToken,
        this.refreshToken,
        this.expires,
        this.expiresIn,
        this.issued,
        this.tokenType,
        this.userName});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
        accessToken: json['access_token'],
        expires: json['.expires'],
        expiresIn: json['expires_in'],
        issued: json['.issued'],
        tokenType: json['token_type'],
        userName: json['userName'],
        refreshToken: json['refresh_token']);
  }
}
