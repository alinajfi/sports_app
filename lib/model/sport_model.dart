class SportModel {
  final int id;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SportModel({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory SportModel.fromJson(Map<String, dynamic> json) {
    return SportModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class SportsResponse {
  final bool success;
  final String message;
  final List<SportModel> data;

  SportsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SportsResponse.fromJson(Map<String, dynamic> json) {
    return SportsResponse(
      success: json['success'],
      message: json['message'],
      data: List<SportModel>.from(
          json['data'].map((x) => SportModel.fromJson(x))),
    );
  }
}
