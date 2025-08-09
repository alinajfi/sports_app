class CreateStoryModel {
  final String publisher;
  final String contentType;
  final String privacy;
  final String? description;
  final String? color;
  final String? bgColor;
  final String? storyFilePath; // path to local file

  CreateStoryModel({
    required this.publisher,
    required this.contentType,
    required this.privacy,
    this.description,
    this.color,
    this.bgColor,
    this.storyFilePath,
  });

  /// For sending as form data (not JSON)
  Map<String, String> toMap() {
    final map = <String, String>{
      'publisher': publisher,
      'content_type': contentType,
      'privacy': privacy,
    };
    if (contentType == 'text') {
      if (description != null) map['description'] = description!;
      if (color != null) map['color'] = color!;
      if (bgColor != null) map['bg-color'] = bgColor!;
    }
    return map;
  }
}
