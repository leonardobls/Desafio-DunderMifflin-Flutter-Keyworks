import 'package:dunder_mifflin/data/models/user_model.dart';

abstract class LoginState {
  final UserLogin? user;
  final UserResponse? userResponse;

  LoginState({this.user, this.userResponse});
}

class LoginInitialState extends LoginState {
  LoginInitialState() : super(user: UserLogin());
}

class LoginLoadingState extends LoginState {
  LoginLoadingState() : super(user: UserLogin());
}

class LoginLoadedState extends LoginState {
  LoginLoadedState({required super.userResponse});
}

class LoginErrorState extends LoginState {
  final Exception exception;

  LoginErrorState({required this.exception}) : super(user: UserLogin());
}
