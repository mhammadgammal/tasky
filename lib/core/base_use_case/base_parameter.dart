class BaseParameter{}

class LoginParameter extends BaseParameter{
  late String phone;
  late String password;
  LoginParameter(this.phone, this.password);
}

class RegisterParameter extends BaseParameter{
  late String name;

  late String yearsOfExperience;

  late String level;

  late String address;

  late String phoneNumber;

  late String password;

  RegisterParameter(
      this.name,
      this.level,
      this.address,
      this.password,
      this.phoneNumber,
      this.yearsOfExperience,
      );
}