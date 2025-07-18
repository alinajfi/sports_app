import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:prime_social_media_flutter_ui_kit/constants/api_constants.dart';
import 'package:prime_social_media_flutter_ui_kit/model/login_response_model.dart';
import 'package:prime_social_media_flutter_ui_kit/model/user_model.dart';
import 'package:prime_social_media_flutter_ui_kit/utils/common_api_functions.dart';

class AuthService extends CommonApiFunctions {
  Future<(String, bool)> registerUser({
    required String email,
    required String password,
  }) async {
    //************* Response Type From Api *///
    //{"status":200,"user_id":17,"message":"User registered","success":true}
    final url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.register}");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final message = jsonDecode(response.body)["message"];
        log("User registered successfully: $message");
        return (message as String, true);
      } else {
        final error =
            jsonDecode(response.body)["message"] ?? response.reasonPhrase;
        log("Failed to register: $error");
        return (error as String, false);
      }
    } catch (e) {
      log("Registration error: $e");
      return (e as String, false);
    }
  }

  Future<LoginResponse> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.login}")
        .replace(queryParameters: {
      "email": email,
      "password": password,
    });

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(jsonResponse);
        return loginResponse;
      } else {
        final error =
            jsonDecode(response.body)["message"] ?? response.reasonPhrase;
        log("Failed to log in: $error");
        throw Exception("Login failed: $error");
      }
    } catch (e) {
      log("Login error: $e");
      throw Exception("Login error: $e");
    }
  }

  Future<UserData?> getUser() async {
    final response = await http.get(
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        getUrlFromEndPoints(endPoint: ApiConstants.user));

    if (response.statusCode == 200) {
      log("-----------------");
    }
    return null;
  }
}
