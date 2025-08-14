import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/services/chat_service.dart';

class MessageChatController extends GetxController {
  ChatService _service = ChatService();

  TextEditingController typeMessageController = TextEditingController();
  FocusNode messageFocusNode = FocusNode();

  @override
  void onClose() {
    messageFocusNode.dispose();
    super.onClose();
  }
}
