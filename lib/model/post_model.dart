class PostModel {
  final int postId;
  final int userId;
  final String name;
  final String photo;
  final String publisher;
  final int publisherId;
  final String postType;
  final String fileType;
  final String privacy;
  final String location;
  final List<String> postImages;
  final String thumbnail;
  final dynamic userReaction;
  final String description;
  final int commentsCount;
  final ReactionCounts reactionCounts;
  final int total;
  final String createdAt;
  final String follow;
  final List<dynamic> taggedUserList;

  PostModel({
    required this.postId,
    required this.userId,
    required this.name,
    required this.photo,
    required this.publisher,
    required this.publisherId,
    required this.postType,
    required this.fileType,
    required this.privacy,
    required this.location,
    required this.postImages,
    required this.thumbnail,
    required this.userReaction,
    required this.description,
    required this.commentsCount,
    required this.reactionCounts,
    required this.total,
    required this.createdAt,
    required this.follow,
    required this.taggedUserList,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['post_id'],
      userId: json['user_id'],
      name: json['name'],
      photo: json['photo'],
      publisher: json['publisher'],
      publisherId: json['publisherId'],
      postType: json['post_type'],
      fileType: json['fileType'],
      privacy: json['privacy'],
      location: json['location'],
      postImages: List<String>.from(json['post_images']),
      thumbnail: json['thumbnail'],
      userReaction: json['userReaction'],
      description: json['description'],
      commentsCount: json['commentsCount'],
      reactionCounts: ReactionCounts.fromJson(json['reaction_counts']),
      total: json['total'],
      createdAt: json['created_at'],
      follow: json['follow'],
      taggedUserList: List<dynamic>.from(json['taggedUserList']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'post_id': postId,
      'user_id': userId,
      'name': name,
      'photo': photo,
      'publisher': publisher,
      'publisherId': publisherId,
      'post_type': postType,
      'fileType': fileType,
      'privacy': privacy,
      'location': location,
      'post_images': postImages,
      'thumbnail': thumbnail,
      'userReaction': userReaction,
      'description': description,
      'commentsCount': commentsCount,
      'reaction_counts': reactionCounts.toJson(),
      'total': total,
      'created_at': createdAt,
      'follow': follow,
      'taggedUserList': taggedUserList,
    };
  }
}

class ReactionCounts {
  final int like;
  final int love;
  final int sad;
  final int haha;
  final int angry;

  ReactionCounts({
    required this.like,
    required this.love,
    required this.sad,
    required this.haha,
    required this.angry,
  });

  factory ReactionCounts.fromJson(Map<String, dynamic> json) {
    return ReactionCounts(
      like: json['like'],
      love: json['love'],
      sad: json['sad'],
      haha: json['haha'],
      angry: json['angry'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'like': like,
      'love': love,
      'sad': sad,
      'haha': haha,
      'angry': angry,
    };
  }
}
