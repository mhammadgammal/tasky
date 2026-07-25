import 'package:dartz/dartz.dart' show Either;
import 'package:tasky/core/network/failures/failure.dart' show Failure;
import 'package:tasky/core/network/handle_response.dart';
import 'package:tasky/core/user/user_model.dart';
import 'package:tasky/features/profile/data/data_source/profile_data_source.dart';

abstract interface class ProfileRepoI {
  Future<Either<Failure, UserModel>> getProfileData();
}

class ProfileRepoImp implements ProfileRepoI {
  final ProfileDataSourceI _dataSource;

  ProfileRepoImp(this._dataSource);

  @override
  Future<Either<Failure, UserModel>> getProfileData() => handleResponse(
        _dataSource.getProfile(),
        (response) => UserModel.fromJson(response.data),
      );
}
