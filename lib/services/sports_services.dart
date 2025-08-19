import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:prime_social_media_flutter_ui_kit/utils/common_api_functions.dart';

import '../model/sport_model.dart';

class SportsServices extends CommonApiFunctions {
  Future<SportsResponse> fetchSports() async {
    final url = getUrlFromEndPoints(endPoint: "/sports");
    final response = await http.get(url, headers: getHeadersWithTokenJson());

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return SportsResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load sports: ${response.statusCode}');
    }
  }

  Future<bool> selectSports(int sportId) async {
    final url = getUrlFromEndPoints(endPoint: "/select-sport");
    final response =
        await http.post(url, headers: getHeadersWithToken(), body: {
      'sport_ids': sportId.toString(),
    });

    if (response.statusCode == 200) {
      print('Sports selected successfully: ${response.body}');
      return true;
    } else {
      print('Failed to select sports: ${response.statusCode}');
      print(response.body);
      return false;
    }
  }
}
