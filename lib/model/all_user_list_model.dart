class AllUserListModel {
  final int id;
  final String isChat;
  final int msgthreadId;
  final String name;
  final String photo;

  AllUserListModel({
    required this.id,
    required this.isChat,
    required this.msgthreadId,
    required this.name,
    required this.photo,
  });

  factory AllUserListModel.fromJson(Map<String, dynamic> json) {
    return AllUserListModel(
      id: json['id'],
      isChat: json['isChat'],
      msgthreadId: json['msgthread_id'],
      name: json['name'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isChat': isChat,
      'msgthread_id': msgthreadId,
      'name': name,
      'photo': photo,
    };
  }
}
