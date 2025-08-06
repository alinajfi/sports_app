import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:prime_social_media_flutter_ui_kit/utils/common_api_functions.dart';

class SocialServices extends CommonApiFunctions {
  Future<bool> followPerson({required String userId}) async {
    final url = await getUrlFromEndPoints(endPoint: "follow/$userId");

    final response = await http.post(url, headers: getHeadersWithToken());
    if (response.statusCode == 200) {
      log(response.body.toString());
      return true;
    }
    return false;
  }

  Future<bool> addFriend({required String userId}) async {
    final url = await getUrlFromEndPoints(endPoint: "add_friend/$userId");

    final response = await http.post(url, headers: getHeadersWithToken());
    if (response.statusCode == 200) {
      log(response.body.toString());
      return true;
    }
    return false;
  }
}
