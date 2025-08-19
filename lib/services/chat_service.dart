import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:prime_social_media_flutter_ui_kit/model/chat_model.dart';
import 'package:prime_social_media_flutter_ui_kit/utils/common_api_functions.dart';

class ChatService extends CommonApiFunctions {
  Future<List<ChatModel>> fetchChats() async {
    final url = getUrlFromEndPoints(endPoint: "/chat");

    final response = await http.get(url, headers: getHeadersWithToken());

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((chat) => ChatModel.fromJson(chat)).toList();
    } else {
      throw Exception("Failed to load chats: ${response.statusCode}");
    }
  }
}
