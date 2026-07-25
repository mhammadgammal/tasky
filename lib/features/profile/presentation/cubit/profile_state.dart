part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileDataLoadingState extends ProfileState {}

final class ProfileDataLoadFailState extends ProfileState {
  final String message;

  ProfileDataLoadFailState({required this.message});
}

final class ProfileDataLoadSuccessState extends ProfileState {}
