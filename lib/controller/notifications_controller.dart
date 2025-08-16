import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/services/home_services.dart';

class NotificationsController extends GetxController {
  HomeServices _homeServices = HomeServices();

  bool isLoading = false;

  _show() {
    isLoading = true;
    update();
  }

  _hide() {
    isLoading = false;
    update();
  }

  List notifications = [];

  Future<void> getNotificaitons() async {
    _show();
    notifications = await _homeServices.getNotificaitons();
    _hide();
  }

  @override
  void onInit() {
    super.onInit();
    getNotificaitons();
  }
}
