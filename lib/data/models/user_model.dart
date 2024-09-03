import 'package:dunder_mifflin/data/models/aplication_model.dart';

class UserLogin {
  int? id;
  String? userNameOrEmailAddress;
  String? password;
  bool? rememberClient;

  UserLogin({
    this.id,
    this.userNameOrEmailAddress,
    this.password,
    this.rememberClient,
  });

  Map<String, dynamic> toJson() {
    return {
      'userNameOrEmailAddress': userNameOrEmailAddress,
      'password': password,
      'rememberClient': rememberClient,
    };
  }

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      userNameOrEmailAddress: json['userNameOrEmailAddress'] as String?,
      id: json['id'] as int?,
    );
  }
}

class UserResponse {
  String? accessToken;
  String? encryptedAccessToken;
  int? expireInSeconds;
  int? userId;

  UserResponse({
    this.accessToken,
    this.encryptedAccessToken,
    this.expireInSeconds,
    this.userId,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      accessToken: json['accessToken'] as String?,
      encryptedAccessToken: json['encryptedAccessToken'] as String?,
      expireInSeconds: json['expireInSeconds'] as int?,
      userId: json['userId'] as int?,
    );
  }
}

class User {
  int? id;
  String? name;
  String? emailAddress;
  String? biography;
  String? userPhoto;

  User({
    this.id,
    this.name,
    this.emailAddress,
    this.biography,
    this.userPhoto,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      name: json['name'] as String?,
      emailAddress: json['emailAddress'] as String?,
      biography: json['biography'] as String?,
      userPhoto: json['userPhoto'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'emailAddress': emailAddress,
      'biography': biography,
      'userPhoto': userPhoto,
    };
  }
}

class UserProfile {
  Aplication? application;
  User? user;

  UserProfile({
    this.application,
    this.user,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      application: Aplication.fromJson(json['application']),
      user: User.fromJson(json['user']),
    );
  }
}
