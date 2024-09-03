import 'dart:convert';

import 'package:dunder_mifflin/config/app_config.dart';
import 'package:dunder_mifflin/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future login(UserLogin user) async {
    var url = Uri.parse("${AppConfig.url}api/TokenAuth/Authenticate");

    try {
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(user.toJson()));
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final toReturn = UserResponse.fromJson(body['result']);
        return toReturn;
      } else {
        throw Exception();
      }
    } catch (e) {
      return e;
    }
  }

  Future getProfile() async {
    var url = Uri.parse("${AppConfig.url}api/services/app/Session/GetCurrentLoginInformations");

    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('auth_token') ?? "";

    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final toReturn = UserProfile.fromJson(body['result']);
        return toReturn;
      } else {
        throw Exception();
      }
    } catch (e) {
      return e;
    }
  }

  Future updateProfile(User user) async {
    var url = Uri.parse("${AppConfig.url}api/services/app/User/Update");

    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('auth_token') ?? "";

    Map<String, dynamic> userMap = user.toJson();
    userMap.remove('userPhoto');

    try {
      var response = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode(userMap));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception();
      }
    } catch (e) {
      return e;
    }
  }

  Future updateImageProfile(String image) async {
    var url = Uri.parse("${AppConfig.url}api/services/app/User/UpdateProfilePhoto");

    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('auth_token') ?? "";

    Map<String, String> data = {
      "userPhoto": image,
    };

    try {
      var response = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode(data));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception();
      }
    } catch (e) {
      return e;
    }
  }
}
