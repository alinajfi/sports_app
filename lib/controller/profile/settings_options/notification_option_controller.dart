import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';

class NotificationOptionController extends GetxController {
  RxList<RxBool> switchStates = List.generate(AppSize.size7, (index) => false.obs).obs;

  void toggleSwitchState(int index) {
    switchStates[index].value = !switchStates[index].value;
  }

  RxList<String> notificationOptionsList = [
    AppString.hideLike,
    AppString.quietMode,
    AppString.like,
    AppString.post,
    AppString.comments,
    AppString.liveVideo,
    AppString.emailNotification,
  ].obs;
}