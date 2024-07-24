class BaseParameter{}

class LoginParameter extends BaseParameter{
  late String phone;
  late String password;
  LoginParameter(this.phone, this.password);
}

class RegisterParameter extends BaseParameter{
  get name => null;

  get yearsOfExperience => null;

  get level => null;

  get address => null;

  get phoneNumber => null;
}