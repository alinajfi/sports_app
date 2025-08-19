class ChatModel {
  final int id;
  final int reciverId;
  final int senderId;
  final int profileId;
  final String profileName;
  final String profilePhoto;
  final String msgSender;
  final String lastMsg;
  final int lastThumbs;
  final String msgTime;
  final int read;

  ChatModel({
    required this.id,
    required this.reciverId,
    required this.senderId,
    required this.profileId,
    required this.profileName,
    required this.profilePhoto,
    required this.msgSender,
    required this.lastMsg,
    required this.lastThumbs,
    required this.msgTime,
    required this.read,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] ?? 0,
      reciverId: json['reciver_id'] ?? 0,
      senderId: json['sender_id'] ?? 0,
      profileId: json['profile_id'] ?? 0,
      profileName: json['profile_name'] ?? '',
      profilePhoto: json['profile_photo'] ?? '',
      msgSender: json['msg_sender'] ?? '',
      lastMsg: json['last_msg'] ?? '',
      lastThumbs: json['last_thumbs'] ?? 0,
      msgTime: json['msg_time'] ?? '',
      read: json['read'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reciver_id': reciverId,
      'sender_id': senderId,
      'profile_id': profileId,
      'profile_name': profileName,
      'profile_photo': profilePhoto,
      'msg_sender': msgSender,
      'last_msg': lastMsg,
      'last_thumbs': lastThumbs,
      'msg_time': msgTime,
      'read': read,
    };
  }
}
