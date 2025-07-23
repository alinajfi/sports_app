import 'dart:convert';

class UserData {
  final int id;
  final String userType;
  final String isInHouse;
  final String? name;
  final String email;
  final String? phone;
  final String? address;
  final String? postalCode;
  final String? tradeName;
  final String? profilePic;
  final String? photoId;
  final String? addressProof;
  final String? certificate;
  final String? insuranceDocument;
  final String? skills;
  final String? emailVerifiedAt;
  final String apiToken;
  final String apiTokenExpiry;
  final String active;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String propertyId;

  UserData({
    required this.id,
    required this.userType,
    required this.isInHouse,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.postalCode,
    required this.tradeName,
    required this.profilePic,
    required this.photoId,
    required this.addressProof,
    required this.certificate,
    required this.insuranceDocument,
    required this.skills,
    required this.emailVerifiedAt,
    required this.apiToken,
    required this.apiTokenExpiry,
    required this.active,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.propertyId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      userType: json['user_type'],
      isInHouse: json['is_in_house'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      postalCode: json['postal_code'],
      tradeName: json['trade_name'],
      profilePic: json['profile_pic'],
      photoId: json['photo_id'],
      addressProof: json['address_proof'],
      certificate: json['certificate'],
      insuranceDocument: json['insurance_document'],
      skills: json['skills'],
      emailVerifiedAt: json['email_verified_at'],
      apiToken: json['api_token'],
      apiTokenExpiry: json['api_token_expiry'],
      active: json['active'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      propertyId: json['property_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_type': userType,
      'is_in_house': isInHouse,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'postal_code': postalCode,
      'trade_name': tradeName,
      'profile_pic': profilePic,
      'photo_id': photoId,
      'address_proof': addressProof,
      'certificate': certificate,
      'insurance_document': insuranceDocument,
      'skills': skills,
      'email_verified_at': emailVerifiedAt,
      'api_token': apiToken,
      'api_token_expiry': apiTokenExpiry,
      'active': active,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'property_id': propertyId,
    };
  }
}

class UserModel {
  final int id;
  final String userRole;
  final String username;
  final String email;
  final String name;
  final String? nickname;
  final List<dynamic> friends;
  final int followers;
  final int following;
  final String? gender;
  final String? studiedAt;
  final String? address;
  final String? profession;
  final String? job;
  final String? maritalStatus;
  final String? phone;
  final String? dateOfBirth;
  final String? about;
  final String photo;
  final String? coverPhoto;
  final String status;
  final String lastActive;
  final String timezone;
  final String? emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final String? paymentSettings;

  UserModel({
    required this.id,
    required this.userRole,
    required this.username,
    required this.email,
    required this.name,
    this.nickname,
    required this.friends,
    required this.followers,
    required this.following,
    this.gender,
    this.studiedAt,
    this.address,
    this.profession,
    this.job,
    this.maritalStatus,
    this.phone,
    this.dateOfBirth,
    this.about,
    required this.photo,
    this.coverPhoto,
    required this.status,
    required this.lastActive,
    required this.timezone,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    this.paymentSettings,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      userRole: json['user_role'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      nickname: json['nickname'],
      friends: json['friends'] is String
          ? (jsonDecode(json['friends']) ?? [])
          : (json['friends'] ?? []),
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      gender: json['gender'],
      studiedAt: json['studied_at'],
      address: json['address'],
      profession: json['profession'],
      job: json['job'],
      maritalStatus: json['marital_status'],
      phone: json['phone'],
      dateOfBirth: json['date_of_birth'],
      about: json['about'],
      photo: json['photo'] ?? '',
      coverPhoto: json['cover_photo'],
      status: json['status'] ?? '0',
      lastActive: json['lastActive'] ?? '',
      timezone: json['timezone'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      paymentSettings: json['payment_settings'],
    );
  }
}

class EditProfileUser {
  final int id;
  final String username;
  final String? name;
  final String? nickname;
  final String? phone;
  final String? photo;
  final String? coverPhoto;

  EditProfileUser({
    required this.id,
    required this.username,
    this.name,
    this.nickname,
    this.phone,
    this.photo,
    this.coverPhoto,
  });

  factory EditProfileUser.fromJson(Map<String, dynamic> json) {
    return EditProfileUser(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      nickname: json['nickname'],
      phone: json['phone'],
      photo: json['photo'],
      coverPhoto: json['cover_photo'],
    );
  }
}
