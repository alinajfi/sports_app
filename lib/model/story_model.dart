class StoryModel {
  final int storyId;
  final int userId;
  final String name;
  final String photo;
  final String publisher;
  final String fileType;
  final String privacy;
  final String contentType;
  final String description;
  final String color;
  final String bgColor;
  final String postImages;
  final String createdAt;

  StoryModel({
    required this.storyId,
    required this.userId,
    required this.name,
    required this.photo,
    required this.publisher,
    required this.fileType,
    required this.privacy,
    required this.contentType,
    required this.description,
    required this.color,
    required this.bgColor,
    required this.postImages,
    required this.createdAt,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      storyId: json['story_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      photo: json['photo'] ?? '',
      publisher: json['publisher'] ?? '',
      fileType: json['fileType'] ?? '',
      privacy: json['privacy'] ?? '',
      contentType: json['content_type'] ?? '',
      description: json['description'] ?? '',
      color: json['color'] ?? '',
      bgColor: json['bg-color'] ?? '',
      postImages: json['post_images'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'story_id': storyId,
      'user_id': userId,
      'name': name,
      'photo': photo,
      'publisher': publisher,
      'fileType': fileType,
      'privacy': privacy,
      'content_type': contentType,
      'description': description,
      'color': color,
      'bg-color': bgColor,
      'post_images': postImages,
      'created_at': createdAt,
    };
  }
}
