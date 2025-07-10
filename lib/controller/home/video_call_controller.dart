import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_image.dart';

class VideoCallController extends GetxController {
  RxList<String> videoCallList = [
    AppImage.videoCall3,
    AppImage.videoCall4,
    AppImage.videoCall5,
    AppImage.videoCall6,
  ].obs;
}