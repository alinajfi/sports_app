import 'package:prime_social_media_flutter_ui_kit/model/user_model.dart';

class LoginResponse {
  final bool success;
  final UserData data;
  final String message;

  LoginResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      data: UserData.fromJson(json['data']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data.toJson(),
        'message': message,
      };
}
