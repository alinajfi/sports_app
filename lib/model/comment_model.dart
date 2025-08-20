class Comment {
  final int commentId;
  final int postId;
  final int userId;
  final String postType;
  final String description;
  final String name;
  final String photo;
  final dynamic userReaction;
  final ReactionCounts reactionCounts;
  final String created;
  final List<dynamic> replies;

  Comment({
    required this.commentId,
    required this.postId,
    required this.userId,
    required this.postType,
    required this.description,
    required this.name,
    required this.photo,
    required this.userReaction,
    required this.reactionCounts,
    required this.created,
    required this.replies,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['comment_id'],
      postId: json['post_id'],
      userId: json['user_id'],
      postType: json['post_type'],
      description: json['description'],
      name: json['name'],
      photo: json['photo'],
      userReaction: json['userReaction'],
      reactionCounts: ReactionCounts.fromJson(json['reaction_counts']),
      created: json['created'],
      replies: json['replies'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment_id': commentId,
      'post_id': postId,
      'user_id': userId,
      'post_type': postType,
      'description': description,
      'name': name,
      'photo': photo,
      'userReaction': userReaction,
      'reaction_counts': reactionCounts.toJson(),
      'created': created,
      'replies': replies,
    };
  }

  /// copyWith method
  Comment copyWith({
    int? commentId,
    int? postId,
    int? userId,
    String? postType,
    String? description,
    String? name,
    String? photo,
    dynamic userReaction,
    ReactionCounts? reactionCounts,
    String? created,
    List<dynamic>? replies,
  }) {
    return Comment(
      commentId: commentId ?? this.commentId,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      postType: postType ?? this.postType,
      description: description ?? this.description,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      userReaction: userReaction ?? this.userReaction,
      reactionCounts: reactionCounts ?? this.reactionCounts,
      created: created ?? this.created,
      replies: replies ?? this.replies,
    );
  }
}

class ReactionCounts {
  final int like;
  final int love;
  final int sad;
  final int haha;
  final int angry;
  final int total;

  ReactionCounts({
    required this.like,
    required this.love,
    required this.sad,
    required this.haha,
    required this.angry,
    required this.total,
  });

  factory ReactionCounts.fromJson(Map<String, dynamic> json) {
    return ReactionCounts(
      like: json['like'],
      love: json['love'],
      sad: json['sad'],
      haha: json['haha'],
      angry: json['angry'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'like': like,
      'love': love,
      'sad': sad,
      'haha': haha,
      'angry': angry,
      'total': total,
    };
  }

  /// copyWith method
  ReactionCounts copyWith({
    int? like,
    int? love,
    int? sad,
    int? haha,
    int? angry,
    int? total,
  }) {
    return ReactionCounts(
      like: like ?? this.like,
      love: love ?? this.love,
      sad: sad ?? this.sad,
      haha: haha ?? this.haha,
      angry: angry ?? this.angry,
      total: total ?? this.total,
    );
  }
}
