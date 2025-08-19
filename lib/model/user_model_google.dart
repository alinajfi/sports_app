import 'dart:convert';

class UserModelGoogle {
  final int id;
  final String userRole;
  final String username;
  final String email;
  final String name;
  final String? nickname;
  final List<dynamic> friends;
  final List<dynamic> followers;
  final String? gender;
  final String? studiedAt;
  final String? address;
  final String? profession;
  final String? job;
  final String? maritalStatus;
  final String? phone;
  final String? dateOfBirth;
  final String? about;
  final String? savePost;
  final String photo;
  final String? coverPhoto;
  final String status;
  final String lastActive;
  final String timezone;
  final String? emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final String? paymentSettings;
  final String? postCode;
  final String? facebook;
  final String? instagram;
  final String? tiktok;
  final String? x;
  final String? bio;
  final String? affiliateCode;
  final String? sportId;

  UserModelGoogle({
    required this.id,
    required this.userRole,
    required this.username,
    required this.email,
    required this.name,
    this.nickname,
    required this.friends,
    required this.followers,
    this.gender,
    this.studiedAt,
    this.address,
    this.profession,
    this.job,
    this.maritalStatus,
    this.phone,
    this.dateOfBirth,
    this.about,
    this.savePost,
    required this.photo,
    this.coverPhoto,
    required this.status,
    required this.lastActive,
    required this.timezone,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    this.paymentSettings,
    this.postCode,
    this.facebook,
    this.instagram,
    this.tiktok,
    this.x,
    this.bio,
    this.affiliateCode,
    this.sportId,
  });

  factory UserModelGoogle.fromJson(Map<String, dynamic> json) {
    return UserModelGoogle(
      id: json['id'] ?? 0,
      userRole: json['user_role'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      nickname: json['nickname'],
      friends: _decodeList(json['friends']),
      followers: _decodeList(json['followers']),
      gender: json['gender'],
      studiedAt: json['studied_at'],
      address: json['address'],
      profession: json['profession'],
      job: json['job'],
      maritalStatus: json['marital_status'],
      phone: json['phone'],
      dateOfBirth: json['date_of_birth'],
      about: json['about'],
      savePost: json['save_post'],
      photo: json['photo'] ?? '',
      coverPhoto: json['cover_photo'],
      status: json['status'] ?? '',
      lastActive: json['lastActive'] ?? '',
      timezone: json['timezone'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      paymentSettings: json['payment_settings'],
      postCode: json['post_code'],
      facebook: json['facebook'],
      instagram: json['instagram'],
      tiktok: json['tiktok'],
      x: json['x'],
      bio: json['bio'],
      affiliateCode: json['affiliate_code'],
      sportId: json['sport_id'],
    );
  }

  static List<dynamic> _decodeList(dynamic data) {
    if (data == null) return [];
    if (data is List) return data;
    if (data is String && data.isNotEmpty) {
      try {
        return jsonDecode(data) as List<dynamic>;
      } catch (_) {
        return [];
      }
    }
    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_role": userRole,
      "username": username,
      "email": email,
      "name": name,
      "nickname": nickname,
      "friends": friends,
      "followers": followers,
      "gender": gender,
      "studied_at": studiedAt,
      "address": address,
      "profession": profession,
      "job": job,
      "marital_status": maritalStatus,
      "phone": phone,
      "date_of_birth": dateOfBirth,
      "about": about,
      "save_post": savePost,
      "photo": photo,
      "cover_photo": coverPhoto,
      "status": status,
      "lastActive": lastActive,
      "timezone": timezone,
      "email_verified_at": emailVerifiedAt,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "payment_settings": paymentSettings,
      "post_code": postCode,
      "facebook": facebook,
      "instagram": instagram,
      "tiktok": tiktok,
      "x": x,
      "bio": bio,
      "affiliate_code": affiliateCode,
      "sport_id": sportId,
    };
  }
}
