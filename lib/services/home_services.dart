import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:prime_social_media_flutter_ui_kit/model/comment_model.dart';

import 'package:prime_social_media_flutter_ui_kit/model/post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/model/social_media_post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/utils/common_api_functions.dart';

class HomeServices extends CommonApiFunctions {
  Future<List<PostModel>> fetchTimelinePosts() async {
    final url = Uri.parse('https://mysportsjourney.co.uk/api/timeline');

    final response = await http.get(headers: getHeadersWithTokenJson(), url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)["post"] as List;

      return jsonData.map((postJson) => PostModel.fromJson(postJson)).toList();
    } else {
      throw Exception('Failed to load timeline posts');
    }
  }

  Future<void> addCommentToPost(
      {required String comment, required String postId}) async {
    final url = getUrlFromEndPoints(endPoint: "/post_comment");

    try {
      final response =
          await http.post(headers: getHeaderWithToken(), url, body: {
        "comment_id": "",
        "comment": "comment",
        //if you are replying on a comment then you have to pass the parent id
        "parent_id": "0",
        "is_type": "post",
        //pass the post id here
        "id_of_type": postId,
        "description": comment,
        "react": "",
      });
      log(response.body.toString());
    } catch (e) {
      log("add comments response$e");
    }
  }

//okay 32 post id has comments
  Future<List<Comment>> getCommentOnPosts({required String postId}) async {
    final url = getUrlFromEndPoints(endPoint: "/get_comment/$postId");
    final headers = getHeadersWithTokenJson();
    try {
      final response = await http.get(headers: headers, url);
      List<Comment> comments = [];
      final decodedList = jsonDecode(response.body) as List;
      for (var e in decodedList) {
        comments.add(Comment.fromJson(e));
      }
      return comments;
    } catch (e) {
      log("get comments response$e");
      return [];
    }
  }

  //oka
  Future<bool> addReactionToPost({required String postId}) async {
    final url = getUrlFromEndPoints(endPoint: "/reaction");
    try {
      final response = await http.post(url,
          headers: getHeadersWithToken(),
          body: {"react": "love", "post_id": postId});
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      log("error in adding reaction $e");
      return false;
    }
  }

  getPostReactions({required String postId}) async {
    final url = getUrlFromEndPoints(endPoint: "/getPostReactions/$postId");
    final response = await http.get(
      url,
      headers: getHeadersWithToken(),
    );
    log(response.body.toString());
  }
}
