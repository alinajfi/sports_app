import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/constants/db_constants.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/bottom_bar/bottom_bar_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/db_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/login_response_model.dart';
import 'package:prime_social_media_flutter_ui_kit/model/post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:prime_social_media_flutter_ui_kit/services/auth_service.dart';
import 'package:prime_social_media_flutter_ui_kit/services/home_services.dart';
import '../../model/highlight_model.dart';

BottomBarController bottomBarController = Get.put(BottomBarController());

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  RxBool isFollow = false.obs;
  RxBool isLiked = false.obs;
  RxInt selectedTabIndex = 0.obs;
  RxInt isSelected = (-1).obs;
  RxList<HighlightItem> highlights = <HighlightItem>[].obs;
  Rx<UserModel?> user = Rx<UserModel?>(null);
  RxBool isLoading = false.obs;

  int get followersCount => user.value?.followers ?? 0;
  int get followingCount => user.value?.following ?? 0;
  var editUser = Rxn<UserModel>();
  final editProfileUser = Rxn<EditProfileUser>();
  final nameController = TextEditingController();
  final nicknameController = TextEditingController();
  final phoneController = TextEditingController();

  List<PostModel> userPosts = [];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      initialIndex: AppSize.size0,
      length: AppSize.size1,
      vsync: this,
    );

    loadUserProfile().then(
      (value) {
        loadUserPosts();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
    isSelected.value = -1;
  }

  Rx<User?> currentUser = Rx<User?>(null);

  Future<void> onLoginSuccessFull() async {
    // Save token if needed
    // currentUser.value = response.user;
    user.value = await AuthService().fetchUserProfile();

    // Navigate to ProfileScreen or HomePage
    // Get.offAll(() => HomeScreen());
  }

  void loadEditFieldsFromUserModel() {
    final u = user.value;
    if (u != null) {
      nameController.text = u.name ?? '';
      nicknameController.text = u.nickname ?? '';
      phoneController.text = u.phone ?? '';
    }
  }

  Future<void> updateProfile(
      {String? name, String? nickName, String? phone}) async {
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
        // Parse with EditProfileUser model
        editProfileUser.value = EditProfileUser.fromJson(data['user']);

        Get.snackbar('Success', 'Profile updated successfully',
            backgroundColor: Colors.green, colorText: Colors.white);

        // OPTIONAL: Reload user profile if needed
        // await loadUserProfile();
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

  // Future<UserModel> fetchUserProfile() async {
  //   final token =
  //       await DbController.instance.readData<String>(DbConstants.apiToken);

  //   final response = await http.get(
  //     Uri.parse("https://mysportsjourney.co.uk/api/profile"),
  //     headers: {
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     return UserModel.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception("Failed to load user profile");
  //   }
  // }

  Future<void> loadUserProfile() async {
    try {
      isLoading.value = true;
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

  void toggleFollow() {
    isFollow.value = !isFollow.value;
  }

  void toggleLike() {
    isLiked.value = !isLiked.value;
  }

  void changeTabIndex(int index) {
    selectedTabIndex.value = index;
  }

  void selectItem(int index) {
    isSelected.value = index;
  }

  void loadUserPostsWithId(String userPostId) async {
    postListWithId.value =
        await HomeServices().getUserPostsWithUserId(userId: userPostId);
  }

  RxList<PostModel> postListWithId = <PostModel>[].obs;

  void loadUserPosts() async {
    postsList.value = await HomeServices().getLoggedInUserPost();
  }

  RxList<PostModel> postsList = <PostModel>[].obs;

  RxList<String> reelsList = [
    AppString.reel1,
    AppString.reel2,
    AppString.reel3,
    AppString.reel4,
    AppString.reel5,
    AppString.reel6,
    AppString.reel7,
    AppString.reel8,
    AppString.reel9,
  ].obs;

  RxList<String> reelsViewList = [
    AppString.reelView500,
    AppString.reelView500k,
    AppString.reelView100k,
    AppString.reelView5and5k,
    AppString.reelView20k,
    AppString.reelView389,
    AppString.reelView1m,
    AppString.reelView2and5m,
    AppString.reelView78,
  ].obs;

  RxList<String> profileActionsList = [
    AppString.yourActivity,
    AppString.qrCode,
    AppString.saved,
    AppString.closeFriends,
    AppString.settings,
  ].obs;
}
