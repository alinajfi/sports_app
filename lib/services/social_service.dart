import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:prime_social_media_flutter_ui_kit/constants/db_constants.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/db_controller.dart';

import 'package:prime_social_media_flutter_ui_kit/utils/common_api_functions.dart';

import '../model/friend_request_model.dart';

class SocialService extends CommonApiFunctions {
  Future<bool> addFreind({required String userId}) async {
    final url = getUrlFromEndPoints(endPoint: "/add_friend/$userId");
    final resp = await http.post(url, headers: getHeadersWithToken());
    if (resp.statusCode == 200) {
      log(resp.body.toString());
      return true;
    }
    return false;
  }

  Future<bool> followUser({required String userId}) async {
    final url = getUrlFromEndPoints(endPoint: "/follow/$userId");
    final resp = await http.post(url, headers: getHeadersWithToken());
    if (resp.statusCode == 200) {
      log(resp.body.toString());
      return true;
    }
    return false;
  }

  getFrinds() async {
    final url = getUrlFromEndPoints(endPoint: "/friends");

    final resp = await http.get(url, headers: getHeadersWithToken());
    log(resp.body.toString());
  }

  Future<List<FriendRequestModel>?> getFriendRequest() async {
    final url = getUrlFromEndPoints(endPoint: "/friend_request");
    // final userId = DbController.instance.readData<String?>(DbConstants.userId);

    final resp = await http.get(url, headers: getHeadersWithToken());
    final data = List.from(jsonDecode(resp.body)['friendsList'] ?? []);

    final list = data.map((e) => FriendRequestModel.fromJson(e)).toList();

    // list.removeWhere((element) => element.friendId.toString() == userId);

    return list;

    // if (userId != null && userId.isNotEmpty) {}
    //  return null;
  }

  unfriend() {
    "/unfriend/{id}";
  }

  unfollow() {
    "/unfollow/{id}";
  }
}
