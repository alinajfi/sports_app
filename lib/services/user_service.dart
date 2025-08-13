import 'dart:convert';
import 'dart:developer';

import 'package:prime_social_media_flutter_ui_kit/model/parent_details_model.dart';
import 'package:prime_social_media_flutter_ui_kit/utils/common_api_functions.dart';
import 'package:http/http.dart' as http;

class UserService extends CommonApiFunctions {
  Future<void> getUserPosts() async {
    final url = getUrlFromEndPoints(endPoint: "/user_post");

    var headers = await getHeadersWithTokenJson();

    try {
      final response = await http.get(headers: headers, url);

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
      } else {
        print('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<bool> storeParentDetails(ParentDetailsModel details) async {
    final url = getUrlFromEndPoints(endPoint: "/user_parents");

    try {
      final response = await http.post(
        url,
        headers: getHeadersWithToken(),
        body: {
          "user_id": details.userId.toString(),
          "email": details.email ?? "",
          "phone": details.phone ?? "",
          "name": details.name ?? "",
          "post_code": details.postCode ?? "",
          "date_of_birth": details.dateOfBirth ?? "",
          "address": details.address ?? "",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Error storing parent details: $e");
      return false;
    }
  }
}
