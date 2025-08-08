import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/db_constants.dart';
import '../../model/post_model.dart';
import '../../model/user_model.dart';
import '../../services/home_services.dart';
import '../db_controller.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Tab management
  late TabController tabController;
  RxInt selectedTabIndex = 0.obs;

  // Loading states
  RxBool isLoading = false.obs;

  // User Profile
  Rx<UserModel?> user = Rx<UserModel?>(null);
  int get followersCount => user.value?.followers ?? 0;
  int get followingCount => user.value?.following ?? 0;

  // Text Controllers for Edit Profile
  final nameController = TextEditingController();
  final nicknameController = TextEditingController();
  final phoneController = TextEditingController();

  // Posts
  RxList<PostModel> postsList = <PostModel>[].obs;
  RxList<PostModel> postListWithId = <PostModel>[].obs;

  // Edit profile model
  final editProfileUser = Rxn<EditProfileUser>();

  // UI state
  RxBool isFollow = false.obs;
  RxBool isLiked = false.obs;
  RxInt isSelected = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 1, vsync: this);
    loadUserProfile().then((_) => loadUserPosts());
  }

  @override
  void dispose() {
    tabController.dispose();
    isSelected.value = -1;
    super.dispose();
  }

  // Load user profile
  Future<void> loadUserProfile() async {
    isLoading.value = true;
    try {
      final token =
          await DbController.instance.readData<String>(DbConstants.apiToken);
      final response = await http.get(
        Uri.parse("https://mysportsjourney.co.uk/api/profile"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        user.value = UserModel.fromJson(jsonData);
        loadEditFieldsFromUserModel();
        print("Profile loaded: ${user.value?.username}");
      } else {
        throw Exception("Failed to load user profile");
      }
    } catch (e) {
      print("Profile error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Load posts for logged-in user
  Future<void> loadUserPosts() async {
    try {
      postsList.value = await HomeServices().getLoggedInUserPost();
    } catch (e) {
      print("Error loading posts: $e");
    }
  }

  // Load posts by user ID
  Future<void> loadUserPostsWithId(String userPostId) async {
    try {
      postListWithId.value =
          await HomeServices().getUserPostsWithUserId(userId: userPostId);
    } catch (e) {
      print("Error loading posts by ID: $e");
    }
  }

  // Update Profile
  Future<void> updateProfile() async {
    isLoading.value = true;
    try {
      final token =
          await DbController.instance.readData<String>(DbConstants.apiToken);
      final response = await http.post(
        Uri.parse('https://mysportsjourney.co.uk/api/edit_profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {
          'name': nameController.text.trim(),
          'nickname': nicknameController.text.trim(),
          'phone': phoneController.text.trim(),
        },
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200 && data['status'] == 200) {
        editProfileUser.value = EditProfileUser.fromJson(data['user']);
        Get.snackbar('Success', 'Profile updated successfully',
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'Failed to update profile',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // Pre-fill edit form
  void loadEditFieldsFromUserModel() {
    final u = user.value;
    if (u != null) {
      nameController.text = u.name ?? '';
      nicknameController.text = u.nickname ?? '';
      phoneController.text = u.phone ?? '';
    }
  }

  // UI toggles
  void toggleFollow() => isFollow.toggle();
  void toggleLike() => isLiked.toggle();
  void changeTabIndex(int index) => selectedTabIndex.value = index;
  void selectItem(int index) => isSelected.value = index;
}
