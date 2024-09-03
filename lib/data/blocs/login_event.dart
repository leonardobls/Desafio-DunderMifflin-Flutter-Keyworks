import 'package:dunder_mifflin/data/models/user_model.dart';

abstract class LoginEvent {}

class PostLogin extends LoginEvent {
  final UserLogin user;

  PostLogin({required this.user});
}

class CloseDilog extends LoginEvent {
  CloseDilog();
}
