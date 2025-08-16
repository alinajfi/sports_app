import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:http_parser/http_parser.dart';

import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prime_social_media_flutter_ui_kit/constants/db_constants.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/db_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/all_user_list_model.dart';
import 'package:prime_social_media_flutter_ui_kit/model/comment_model.dart';
import 'package:path/path.dart';
import 'package:prime_social_media_flutter_ui_kit/model/create_story_model.dart';

import 'package:prime_social_media_flutter_ui_kit/model/post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/model/social_media_post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/model/user_model.dart';
import 'package:prime_social_media_flutter_ui_kit/utils/common_api_functions.dart';

import '../model/create_post_model.dart';
import '../model/story_model.dart';

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

  Future<List<AllUserListModel>> getAllUsers() async {
    final url = getUrlFromEndPoints(endPoint: "/all_user");

    final response = await http.get(
      url,
      headers: getHeadersWithToken(),
    );

    if (response.statusCode == 200) {
      List<AllUserListModel> users = (jsonDecode(response.body) as List)
          .map((e) => AllUserListModel.fromJson(e))
          .toList();
      return users;
    }
    return [];
  }

  Future<UserModel> getUserProfileWithId({required String userId}) async {
    final url = getUrlFromEndPoints(endPoint: "/profile?user_id=$userId");
    final response = await http.get(url, headers: getHeadersWithToken());
    return UserModel.fromJson(jsonDecode(response.body));
  }

  Future<List<PostModel>> getUserPostsWithUserId(
      {required String userId}) async {
    final url = getUrlFromEndPoints(endPoint: "/profile?user_id=$userId");
    final response = await http.get(url, headers: getHeadersWithToken());
    final postsFromServer = jsonDecode(response.body)["posts"] as List;
    return postsFromServer
        .map(
          (e) => PostModel.fromJson(e),
        )
        .toList();
  }

  Future<List<PostModel>> getLoggedInUserPost() async {
    final url = getUrlFromEndPoints(endPoint: "/profile");
    final response = await http.get(url, headers: getHeadersWithToken());
    final postsFromServer = jsonDecode(response.body)["posts"] as List;
    return postsFromServer
        .map(
          (e) => PostModel.fromJson(e),
        )
        .toList();
  }

  Future<List<StoryModel>> getStories() async {
    final url = getUrlFromEndPoints(endPoint: "/stories");

    try {
      final response = await http.get(url, headers: getHeadersWithToken());
      final decodedData = jsonDecode(response.body)['stories'] as List;

      return decodedData
          .map(
            (e) => StoryModel.fromJson(e),
          )
          .toList();
    } catch (e) {
      log(e.toString());
    }

    return [];
  }

  Future<bool> createStory(CreateStoryModel request) async {
    var uri = getUrlFromEndPoints(endPoint: "/create_story");

    var requestMultipart = http.MultipartRequest('POST', uri);

    // Add fields
    requestMultipart.fields.addAll(request.toMap());

    // Add file if not text
    if (request.contentType != 'text' && request.storyFilePath != null) {
      File file = File(request.storyFilePath!);
      requestMultipart.files.add(
        await http.MultipartFile.fromPath(
          'story_files',
          file.path,
          filename: basename(file.path),
        ),
      );
    }

    // Add Bearer token
    requestMultipart.headers['Authorization'] =
        'Bearer ${DbController.instance.readData(DbConstants.apiToken)}';

    // Send request
    var response = await requestMultipart.send();

    // Handle response
    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      log('Story created: $body');
      return true;
    } else {
      print('Failed to create story: ${response.statusCode}');
      return false;
    }
  }

  Future<bool> addPost(
    CreatePostModel postData,
  ) async {
    final url = getUrlFromEndPoints(endPoint: "/create_post");

    final request = http.MultipartRequest('POST', url);
    request.headers.addAll(CommonApiFunctions().getHeadersWithTokenJson()!);

    // Required Fields
    request.fields['privacy'] = postData.privacy;
    request.fields['publisher'] = postData.publisher;
    request.fields['post_type'] = postData.postType;

    // Optional Fields
    if (postData.description != null) {
      request.fields['description'] = postData.description!;
    }

    if (postData.taggedUsersId != null && postData.taggedUsersId!.isNotEmpty) {
      for (var id in postData.taggedUsersId!) {
        request.fields['tagged_users_id[]'] = id.toString();
      }
    }

    if (postData.feelingAndActivityId != null) {
      request.fields['feeling_and_activity_id'] =
          postData.feelingAndActivityId.toString();
    }

    if (postData.address != null) {
      request.fields['address'] = postData.address!;
    }

    if (postData.eventId != null) {
      request.fields['event_id'] = postData.eventId.toString();
    }

    if (postData.pageId != null) {
      request.fields['page_id'] = postData.pageId.toString();
    }

    if (postData.groupId != null) {
      request.fields['group_id'] = postData.groupId.toString();
    }

    // 🔄 Upload multiple files as 'pictures[]'
    if (postData.multipleFiles != null && postData.multipleFiles!.isNotEmpty) {
      for (final file in postData.multipleFiles!) {
        if (file.existsSync()) {
          final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
          final mimeTypeSplit = mimeType.split('/');
          final multipartFile = await http.MultipartFile.fromPath(
            'multiple_files[]', // <-- Make sure this matches backend key!
            file.path,
            contentType: MediaType(mimeTypeSplit[0], mimeTypeSplit[1]),
            filename: basename(file.path),
          );
          request.files.add(multipartFile);
          log('📷 Attached file to pictures[]: ${file.path}');
        } else {
          log('❌ Skipped file (does not exist): ${file.path}');
        }
      }
    }

    // 🔄 Also add first image as 'mobile_app_image'
    if (postData.multipleFiles != null && postData.multipleFiles!.isNotEmpty) {
      final firstFile = postData.multipleFiles!.first;
      if (firstFile.existsSync()) {
        final mimeType = lookupMimeType(firstFile.path) ?? 'image/jpeg';
        final mimeTypeSplit = mimeType.split('/');
        final imageFile = await http.MultipartFile.fromPath(
          'mobile_app_image',
          firstFile.path,
          contentType: MediaType(mimeTypeSplit[0], mimeTypeSplit[1]),
          filename: basename(firstFile.path),
        );
        request.files.add(imageFile);
        log("📷 Attached file to mobile_app_image: ${firstFile.path}");
      }
    }

    // 🧾 Log all fields
    log('📝 Request Fields: ${request.fields}');
    log('➡️ Sending multipart request to: ${url.toString()}');

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log('✅ Response Code: ${response.statusCode}');
      log('🧾 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        return false;
      } else {
        return false;
      }
    } catch (e) {
      log("❌ Error sending multipart post: $e");
      return false;
    }
  }

  Future<bool> editPost(CreatePostModel postData,
      {required String postId}) async {
    final url = getUrlFromEndPoints(endPoint: "/edit_post/$postId");

    final request = http.MultipartRequest('POST', url);
    request.headers.addAll(CommonApiFunctions().getHeadersWithTokenJson()!);

    // Required Fields
    request.fields['privacy'] = postData.privacy;
    request.fields['publisher'] = postData.publisher;
    request.fields['post_type'] = postData.postType;

    // Optional Fields
    if (postData.description != null) {
      request.fields['description'] = postData.description!;
    }

    if (postData.taggedUsersId != null && postData.taggedUsersId!.isNotEmpty) {
      for (var id in postData.taggedUsersId!) {
        request.fields['tagged_users_id[]'] = id.toString();
      }
    }

    if (postData.feelingAndActivityId != null) {
      request.fields['feeling_and_activity_id'] =
          postData.feelingAndActivityId.toString();
    }

    if (postData.address != null) {
      request.fields['address'] = postData.address!;
    }

    if (postData.eventId != null) {
      request.fields['event_id'] = postData.eventId.toString();
    }

    if (postData.pageId != null) {
      request.fields['page_id'] = postData.pageId.toString();
    }

    if (postData.groupId != null) {
      request.fields['group_id'] = postData.groupId.toString();
    }

    // 🔄 Upload multiple files as 'pictures[]'
    if (postData.multipleFiles != null && postData.multipleFiles!.isNotEmpty) {
      for (final file in postData.multipleFiles!) {
        if (file.existsSync()) {
          final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
          final mimeTypeSplit = mimeType.split('/');
          final multipartFile = await http.MultipartFile.fromPath(
            'multiple_files[]', // <-- Make sure this matches backend key!
            file.path,
            contentType: MediaType(mimeTypeSplit[0], mimeTypeSplit[1]),
            filename: basename(file.path),
          );
          request.files.add(multipartFile);
          log('📷 Attached file to pictures[]: ${file.path}');
        } else {
          log('❌ Skipped file (does not exist): ${file.path}');
        }
      }
    }

    // 🔄 Also add first image as 'mobile_app_image'
    if (postData.multipleFiles != null && postData.multipleFiles!.isNotEmpty) {
      final firstFile = postData.multipleFiles!.first;
      if (firstFile.existsSync()) {
        final mimeType = lookupMimeType(firstFile.path) ?? 'image/jpeg';
        final mimeTypeSplit = mimeType.split('/');
        final imageFile = await http.MultipartFile.fromPath(
          'mobile_app_image',
          firstFile.path,
          contentType: MediaType(mimeTypeSplit[0], mimeTypeSplit[1]),
          filename: basename(firstFile.path),
        );
        request.files.add(imageFile);
        log("📷 Attached file to mobile_app_image: ${firstFile.path}");
      }
    }

    // 🧾 Log all fields
    log('📝 Request Fields: ${request.fields}');
    log('➡️ Sending multipart request to: ${url.toString()}');

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log('✅ Response Code: ${response.statusCode}');
      log('🧾 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        return false;
      } else {
        return false;
      }
    } catch (e) {
      log("❌ Error sending multipart post: $e");
      return false;
    }
  }

  dynamic getNotificaitons() async {
    final url = getUrlFromEndPoints(endPoint: "/notifications	");

    final response = await http.get(url, headers: getHeadersWithToken());
    if (response.statusCode == 200) {
      log(response.body.toString());
      return [];
    }
    return [];
  }
}
