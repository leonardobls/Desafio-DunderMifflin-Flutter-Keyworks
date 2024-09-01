import 'package:dunder_mifflin/data/models/user_model.dart';

abstract class LoginEvent {}

class PostLogin extends LoginEvent {
  final User user;

  PostLogin({required this.user});
}
