class LoginResponse {
  final String message;
  final User user;
  final int userId;
  final String userImage;
  final String coverPhoto;
  final String token;

  LoginResponse({
    required this.message,
    required this.user,
    required this.userId,
    required this.userImage,
    required this.coverPhoto,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? '',
      user: User.fromJson(json['user']),
      userId: json['user_id'] ?? 0,
      userImage: json['user_image'] ?? '',
      coverPhoto: json['cover_photo'] ?? '',
      token: json['token'] ?? '',
    );
  }
}

class User {
  final int id;
  final String userRole;
  final String username;
  final String email;
  final String name;
  final String? nickname;
  final String friends;
  final String followers;
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
  final dynamic sportId;

  User({
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      userRole: json['user_role'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      nickname: json['nickname'],
      friends: json['friends'] ?? '',
      followers: json['followers'] ?? '',
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
      status: json['status'] ?? '0',
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
}
