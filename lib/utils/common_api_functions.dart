import 'dart:developer';

import 'package:prime_social_media_flutter_ui_kit/constants/api_constants.dart';
import 'package:prime_social_media_flutter_ui_kit/constants/db_constants.dart';

import '../controller/db_controller.dart';

class CommonApiFunctions {
  Uri getUrlFromEndPoints({required String endPoint}) {
    final url = Uri.parse(ApiConstants.baseUrl + endPoint);
    return url;
  }

  Map<String, String>? getHeadersWithToken() {
    try {
      final apiToken =
          DbController.instance.readData<String>(DbConstants.apiToken);

      final token = apiToken; // Adjust field name based on your model

      return {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Map<String, String>? getHeadersWithTokenJson() {
    try {
      final apiToken =
          DbController.instance.readData<String>(DbConstants.apiToken);

      final token = apiToken; // Adjust field name based on your model

      return {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Map<String, String> headersWithOutTokeAccpetJsonType() {
    return {
      'Accept': 'application/json',
    };
  }
}





//[log] {id: 22, user_type: 3, is_in_house: 0, name: null, email: abbas@gmail.com, phone: null, address: null, postal_code: null, trade_name: null, profile_pic: null, photo_id: null, address_proof: null, certificate: null, insurance_document: null, skills: null, email_verified_at: null, api_token: VH3fDfCfT55cstZeUGBsO7Gmq363XU6YLMmcbIqeIC5xsoEk8L9DJNYgzxJm, api_token_expiry: 1755129600, active: 1, status: 1, created_at: 2025-07-15T05:46:37.000000Z, updated_at: 2025-07-15T05:46:37.000000Z, property_id: 0}
