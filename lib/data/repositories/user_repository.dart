import 'dart:convert';

import 'package:dunder_mifflin/config/app_config.dart';
import 'package:dunder_mifflin/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future login(User user) async {
    var url = Uri.parse("${AppConfig.url}api/TokenAuth/Authenticate");

    try {
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(user.toJson()));
      if (response.statusCode == 200) {}
    } catch (e) {
      return e;
    }
  }
}
