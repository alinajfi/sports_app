class EditProfileModel {
  // Existing fields
  final String? name;
  final String? nickname;
  final String? phone;
  final String? bio;
  final String? gender;
  final String? dob;

  // New fields
  final String? email;
  final String? location;

  // Alternative/Active fields
  final String? username;
  final String? mobileNumber;

  EditProfileModel({
    this.name,
    this.nickname,
    this.phone,
    this.bio,
    this.gender,
    this.dob,
    this.email,
    this.location,
    this.username,
    this.mobileNumber,
  });

  // Convert JSON -> Model
  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      name: json['name'],
      nickname: json['nickname'],
      phone: json['phone'],
      bio: json['bio'],
      gender: json['gender'],
      dob: json['dob'],
      email: json['email'],
      location: json['location'],
      username: json['username'],
      mobileNumber: json['mobile_number'],
    );
  }

  // Convert Model -> JSON
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "nickname": nickname,
      "phone": phone,
      "bio": bio,
      "gender": gender,
      "dob": dob,
      "email": email,
      "location": location,
      "username": username,
      "mobile_number": mobileNumber,
    };
  }
}
