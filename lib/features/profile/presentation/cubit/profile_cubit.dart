import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/profile/data/repo/profile_repo.dart';

import '../../data/model/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repo) : super(ProfileInitial());

  final ProfileRepoImp _repo;
  ProfileModel? profile;
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
      profile!.experience.toString(),
      profile!.address
    ];
  }

  Future<void> getProfile() async {
    emit(ProfileDataLoadingState());
    try {
      profile = await _repo.getProfileData();
      emit(ProfileDataLoadSuccessState());
    } catch (e) {
      print('error getting profile data due to: $e');
      emit(ProfileDataLoadFailState());
    }
  }
}
