class LoginDto{
  late String id;
  late String accessToken;
  late String refreshToken;

  LoginDto({required this.id, required this.accessToken, required this.refreshToken});

  factory LoginDto.fromJson(Map<String, dynamic> json){
    return LoginDto(
      id: json['_id'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}