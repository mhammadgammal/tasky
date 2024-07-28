import 'package:tasky/features/profile/data/data_source/profile_api_service.dart';
import 'package:tasky/features/profile/data/model/profile_model.dart';

abstract interface class ProfileRepoI {
  Future<ProfileModel> getProfileData();
}

class ProfileRepoImp implements ProfileRepoI {
  final ProfileApiService _apiService;

  ProfileRepoImp(this._apiService);

  @override
  Future<ProfileModel> getProfileData() async {
    var response = await _apiService.getProfile();
    return ProfileModel.fromJson(response.data);
  }
}
