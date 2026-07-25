class RegisterResponse {
  late String name;
  late String yearsOfExperience;
  late String level;
  late String address;
  late String phoneNumber;
  late String password;

  RegisterResponse(
      {required this.name,
      required this.yearsOfExperience,
      required this.level,
      required this.address,
      required this.phoneNumber,
      required this.password});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    name = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': name,
      'experienceYears': yearsOfExperience,
      'level': level,
      'address': address,
      'phone': phoneNumber,
      'password': password
    };
  }
}

enum ExperienceLevel {
  //fresh , junior , midLevel , senior
  fresh,
  junior,
  midLevel,
  senior
}
