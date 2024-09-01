class User {
  String? userNameOrEmailAddress;
  String? password;
  bool? rememberClient;

  User({
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
}
