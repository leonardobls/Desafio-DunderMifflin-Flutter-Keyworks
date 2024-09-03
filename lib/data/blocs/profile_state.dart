import 'package:dunder_mifflin/data/models/user_model.dart';

abstract class ProfileState {
  final UserProfile? userProfile;

  ProfileState({required this.userProfile});
}

class ProfileInitialState extends ProfileState {
  ProfileInitialState() : super(userProfile: UserProfile());
}

class ProfileLoadingState extends ProfileState {
  ProfileLoadingState() : super(userProfile: UserProfile());
}

class ProfileLoadedState extends ProfileState {
  ProfileLoadedState({required super.userProfile});
}

class ProfileErrorState extends ProfileState {
  final Exception exception;

  ProfileErrorState({required this.exception})
      : super(userProfile: UserProfile());
}
