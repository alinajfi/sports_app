// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../model/comment_model.dart';
import '../../services/home_services.dart';

class CommentsController extends GetxController {
  final String postId;

  TextEditingController commentsFieldController = TextEditingController();

  RxBool isLoading = false.obs;

  List<Comment> comments = [];
  CommentsController({
    required this.postId,
  });
  Future<void> getCommments({required String postId}) async {
    isLoading.value = true;
    try {
      comments = await HomeServices().getCommentOnPosts(postId: postId);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> updateComments({required String postId}) async {
    try {
      comments = await HomeServices().getCommentOnPosts(postId: postId);
      update(['comment']);
    } catch (e) {
      log("updating comment faild");
    }
  }

  Future<void> postComments({required String postId}) async {
    try {
      await HomeServices().addCommentToPost(
          postId: postId, comment: commentsFieldController.text.trim());
      if (comments.isNotEmpty) {
        comments.add(comments.first
            .copyWith(description: commentsFieldController.text.trim()));
      } else {
        getCommments(postId: postId);
      }
      update(['comment']);
      updateComments(postId: postId);
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCommments(postId: postId);
  }

  @override
  void dispose() {
    commentsFieldController.clear();
    super.dispose();
  }
}
