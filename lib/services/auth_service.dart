import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:prime_social_media_flutter_ui_kit/constants/api_constants.dart';

class AuthService {
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
        //   headers: {'Content-Type': 'application/x-www-form-urlencoded'},
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

  Future<(String, bool)> loginUser({
    required String email,
    required String password,
  }) async {
    //************* Response Type From Api *///
    //{"status":200,"user_id":17,"message":"User registered","success":true}
    final url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.login}");

    try {
      final response = await http.post(
        url,
        //   headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        // final message = jsonDecode(response.body)["message"];
        log("User logged successfully:");
        return ("", true);
      } else {
        final error =
            jsonDecode(response.body)["message"] ?? response.reasonPhrase;
        log("Failed to log in: $error");
        return (error as String, false);
      }
    } catch (e) {
      log("login error: $e");
      return (e as String, false);
    }
  }
}
