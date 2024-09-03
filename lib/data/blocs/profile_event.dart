import 'package:dunder_mifflin/data/models/user_model.dart';

abstract class ProfileEvent {}

class GetProfile extends ProfileEvent {}

class PostProfileChange extends ProfileEvent {
  final User user;

  PostProfileChange({required this.user});
}
