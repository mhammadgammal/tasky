class RegisterDto {
  late String name;
  late String yearsOfExperience;
  late String level;
  late String address;
  late String phoneNumber;
  late String password;

  RegisterDto(
      {required this.name,
      required this.yearsOfExperience,
      required this.level,
      required this.address,
      required this.phoneNumber,
      required this.password});

  RegisterDto.fromJson(Map<String, dynamic> json) {
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
