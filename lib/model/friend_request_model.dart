class FriendRequestModel {
  final int friendId;
  final String name;
  final String photo;
  final String coverPhoto;

  FriendRequestModel({
    required this.friendId,
    required this.name,
    required this.photo,
    required this.coverPhoto,
  });

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) {
    return FriendRequestModel(
      friendId: json['friend_id'] ?? 0,
      name: json['name'] ?? '',
      photo: json['photo'] ?? '',
      coverPhoto: json['cover_photo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'friend_id': friendId,
      'name': name,
      'photo': photo,
      'cover_photo': coverPhoto,
    };
  }
}
