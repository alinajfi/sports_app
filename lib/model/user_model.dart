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
