class ParentDetailsModel {
  final int userId;
  final String? email;
  final String? phone;
  final String? name;
  final String? postCode;
  final String? dateOfBirth;
  final String? address;

  ParentDetailsModel({
    required this.userId,
    this.email,
    this.phone,
    this.name,
    this.postCode,
    this.dateOfBirth,
    this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "email": email,
      "phone": phone,
      "name": name,
      "post_code": postCode,
      "date_of_birth": dateOfBirth,
      "address": address,
    };
  }

  factory ParentDetailsModel.fromJson(Map<String, dynamic> json) {
    return ParentDetailsModel(
      userId: json["user_id"],
      email: json["email"],
      phone: json["phone"],
      name: json["name"],
      postCode: json["post_code"],
      dateOfBirth: json["date_of_birth"],
      address: json["address"],
    );
  }
}
