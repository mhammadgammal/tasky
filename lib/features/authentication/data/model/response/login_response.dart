class LoginResponse{
  late String id;
  late String accessToken;
  late String refreshToken;

  LoginResponse({required this.id, required this.accessToken, required this.refreshToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json){
    return LoginResponse(
      id: json['_id'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}