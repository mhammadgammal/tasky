part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileDataLoadingState extends ProfileState {}

final class ProfileDataLoadFailState extends ProfileState {}

final class ProfileDataLoadSuccessState extends ProfileState {}
