import 'dart:io';

class CreatePostModel {
  final String privacy; // Required
  final String? description;
  final List<int>? taggedUsersId;
  final int? feelingAndActivityId;
  final String? address;
  final String publisher; // Defaults to "post"
  final int? eventId;
  final int? pageId;
  final int? groupId;
  final String postType; // Defaults to "general"
  final List<File>? multipleFiles;
  final File? mobileAppImage;

  CreatePostModel({
    required this.privacy,
    this.description,
    this.taggedUsersId,
    this.feelingAndActivityId,
    this.address,
    this.publisher = 'post',
    this.eventId,
    this.pageId,
    this.groupId,
    this.postType = 'general',
    this.multipleFiles,
    this.mobileAppImage,
  });
}
