class UserModel {
  late String name;
  late String phone;
  late String yearsOfExperience;
  late String level;
  late String address;

  UserModel(
      {required this.name,
      required this.phone,
      required this.yearsOfExperience,
      required this.level,
      required this.address});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['displayName'],
        phone: json['username'],
        yearsOfExperience: json['experienceYears'].toString(),
        level: json['level'],
        address: json['address'],
      );
}
