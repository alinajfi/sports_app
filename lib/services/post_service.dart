import 'dart:developer';

import 'package:prime_social_media_flutter_ui_kit/constants/api_constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class PostService {
  Future<void> createPost(Map<String, String> postData) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.createPost);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
        },
        body: postData,
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint("Post created successfully: $data");
      } else {
        final error = jsonDecode(response.body)['message'] ?? "Unknown error";
        debugPrint("Failed to create post: $error");
      }
    } catch (e) {
      debugPrint("Error creating post: $e");
    }
  }

  Future<void> getPostOnTimeLine() async {
    final url =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getPostOnTimeline);

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
        },
      );

      log(jsonDecode(response.body.toString()));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint(" fetched successfully: $data");
      } else {
        final error = jsonDecode(response.body)['message'] ?? "Unknown error";
        debugPrint("Failed to get post: $error");
      }
    } catch (e) {
      debugPrint("Error getting post: $e");
    }
  }
}
