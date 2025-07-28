import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:prime_social_media_flutter_ui_kit/model/post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/utils/common_api_functions.dart';

class HomeServices extends CommonApiFunctions {
  Future<List<PostModel>> fetchTimelinePosts() async {
    final url = Uri.parse('https://mysportsjourney.co.uk/api/timeline');

    final response = await http.get(headers: getHeadersWithTokenJson(), url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)["post"] as List;

      return jsonData.map((postJson) => PostModel.fromJson(postJson)).toList();
    } else {
      throw Exception('Failed to load timeline posts');
    }
  }
}
