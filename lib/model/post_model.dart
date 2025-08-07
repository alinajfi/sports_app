class PostModel {
  final int? postId;
  final int? userId;
  final String? name;
  final String? photo;
  final String? publisher;
  final int? publisherId;
  final String? postType;
  final String? fileType;
  final String? privacy;
  final String? location;
  final List<String>? postImages;
  final String? thumbnail;
  final dynamic userReaction;
  final String? description;
  final int? commentsCount;
  final ReactionCounts? reactionCounts;
  final int? total;
  final String? createdAt;
  final String? follow;
  final List<dynamic>? taggedUserList;

  PostModel({
    this.postId,
    this.userId,
    this.name,
    this.photo,
    this.publisher,
    this.publisherId,
    this.postType,
    this.fileType,
    this.privacy,
    this.location,
    this.postImages,
    this.thumbnail,
    this.userReaction,
    this.description,
    this.commentsCount,
    this.reactionCounts,
    this.total,
    this.createdAt,
    this.follow,
    this.taggedUserList,
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
      postImages:
          (json['post_images'] as List?)?.map((e) => e.toString()).toList(),
      thumbnail: json['thumbnail'],
      userReaction: json['userReaction'],
      description: json['description'],
      commentsCount: json['commentsCount'],
      reactionCounts: json['reaction_counts'] != null
          ? ReactionCounts.fromJson(json['reaction_counts'])
          : null,
      total: json['total'],
      createdAt: json['created_at'],
      follow: json['follow'],
      taggedUserList: json['taggedUserList'] as List?,
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
      'reaction_counts': reactionCounts?.toJson(),
      'total': total,
      'created_at': createdAt,
      'follow': follow,
      'taggedUserList': taggedUserList,
    };
  }

  @override
  String toString() {
    return 'PostModel(postId: $postId, userId: $userId, name: $name, photo: $photo, '
        'publisher: $publisher, publisherId: $publisherId, postType: $postType, '
        'fileType: $fileType, privacy: $privacy, location: $location, '
        'postImages: $postImages, thumbnail: $thumbnail, userReaction: $userReaction, '
        'description: $description, commentsCount: $commentsCount, '
        'reactionCounts: $reactionCounts, total: $total, createdAt: $createdAt, '
        'follow: $follow, taggedUserList: $taggedUserList)';
  }
}

class ReactionCounts {
  final int? like;
  final int? love;
  final int? sad;
  final int? haha;
  final int? angry;

  ReactionCounts({
    this.like,
    this.love,
    this.sad,
    this.haha,
    this.angry,
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

  @override
  String toString() {
    return 'ReactionCounts(like: $like, love: $love, sad: $sad, haha: $haha, angry: $angry)';
  }
}
