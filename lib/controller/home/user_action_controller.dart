import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';

class UserActionController extends GetxController {
  RxInt isSelected = 0.obs;

  void selectItem(int index) {
    isSelected.value = index;
  }

  RxList<String> userActionsList = [
    AppString.report,
    AppString.block,
    AppString.showQRCode,
    AppString.copyProfileURL,
    AppString.share,
  ].obs;

  @override
  void dispose() {
    super.dispose();
    isSelected.value = -1;
  }
}