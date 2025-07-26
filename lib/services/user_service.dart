import 'package:prime_social_media_flutter_ui_kit/utils/common_api_functions.dart';
import 'package:http/http.dart' as http;

class UserService extends CommonApiFunctions {
  Future<void> getUserPosts() async {
    final url = getUrlFromEndPoints(endPoint: "/user_post");

    var headers = await getHeadersWithTokenJson();

    try {
      final response = await http.get(headers: headers, url);

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
      } else {
        print('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
