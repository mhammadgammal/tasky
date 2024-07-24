class RegisterDto {
  late String name;
  late String yearsOfExperience;
  late ExperienceLevel level;
  late String address;
  late String phoneNumber;

  RegisterDto(
      {required this.name,
      required this.yearsOfExperience,
      required this.level,
      required this.address,
      required this.phoneNumber});

  RegisterDto.fromJson(Map<String, dynamic> json) {
    name = json['displayName'];
    yearsOfExperience = json['experienceYears'];
    level = json['level'];
    address = json['address'];
    phoneNumber = json['phone'];
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': name,
      'experienceYears': yearsOfExperience,
      'level': level,
      'address': address,
      'phone': phoneNumber,
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
