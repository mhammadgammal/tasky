class ProfileModel {
  late String id;
  late String name;
  late String phone;
  late List<String> roles;
  late bool active;
  late int experience;
  late String address;
  late String level;

  ProfileModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.roles,
    required this.active,
    required this.experience,
    required this.address,
    required this.level,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
      id: json['_id'],
      name: json['displayName'],
      phone: json['username'],
      roles:
          List.generate(json['roles'].length, (index) => json['roles'][index]),
      active: json['active'],
      experience: json['experienceYears'],
      address: json['address'],
      level: json['level']);
}
