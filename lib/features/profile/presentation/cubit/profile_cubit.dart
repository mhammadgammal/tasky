import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/user/user_model.dart';
import 'package:tasky/features/profile/data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repo) : super(ProfileInitial());

  final ProfileRepoImp _repo;
  UserModel? profile;
  List<String> fields = [
    'NAME',
    'PHONE',
    'LEVEL',
    'YEARS OF EXPERIENCE',
    'LOCATION'
  ];

  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);

  List<String> getUserProfileFields() {
    if (profile == null) {
      return [];
    }
    return [
      profile!.name,
      profile!.phone,
      profile!.level,
      profile!.yearsOfExperience,
      profile!.address
    ];
  }

  Future<void> getProfile() async {
    emit(ProfileDataLoadingState());
    final result = await _repo.getProfileData();
    result.fold(
      (failure) => emit(ProfileDataLoadFailState(
        message: failure.message ?? 'Getting data failed, try again later',
      )),
      (userModel) {
        profile = userModel;
        emit(ProfileDataLoadSuccessState());
      },
    );
  }
}
