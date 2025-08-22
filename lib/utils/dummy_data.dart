import '../model/post_model.dart';

final dummyPost = PostModel(
  postId: 1,
  userId: 101,
  name: "John Doe",
  location: "New York, USA",
  photo: "assets/images/callBlurImage2.png", // user profile photo
  createdAt: "2h ago",
  description: "Exploring the beautiful streets of New York 🗽✨. #Travel #NYC",
  postImages: [
    "assets/images/callBlurImage2.png", // image 1
    "assets/images/callBlurImage2.png", // image 2
    "assets/images/callBlurImage2.png", // video
  ],
  commentsCount: 5,
);
