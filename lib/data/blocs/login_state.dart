import 'package:dunder_mifflin/data/models/user_model.dart';

abstract class LoginState {
  final User user;

  LoginState({required this.user});
}

class LoginInitialState extends LoginState {
  LoginInitialState() : super(user: User());
}

class LoginLoadingState extends LoginState {
  LoginLoadingState() : super(user: User());
}

class LoginLoadedState extends LoginState {
  LoginLoadedState({required super.user});
}

class LoginErrorState extends LoginState {
  final Exception exception;

  LoginErrorState({required this.exception}) : super(user: User());
}
