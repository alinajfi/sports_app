import 'package:prime_social_media_flutter_ui_kit/constants/api_constants.dart';

class CommonApiFunctions {
  Uri getUrlFromEndPoints({required String endPoint}) {
    final url = Uri.parse(ApiConstants.baseUrl + endPoint);
    return url;
  }
}
