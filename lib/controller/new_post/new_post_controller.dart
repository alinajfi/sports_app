import 'package:get/get.dart';

import '../../config/app_string.dart';

class NewPostController extends GetxController {
  RxInt isSelected = (-1).obs;

  void selectItem(int index) {
    isSelected.value = index;
  }

  RxList<String> newPostOptionsList = [
    AppString.createPost,
    AppString.createReels,
    AppString.uploadVideo,
    AppString.goLive,
  ].obs;

  @override
  void dispose() {
    super.dispose();
    isSelected.value = -1;
  }
}
