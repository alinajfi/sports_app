import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_icon.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/home/home_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/settings_options/language_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/post_model.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/widgets/image_gallery_screen.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/widgets/post_actions.dart';
import 'package:prime_social_media_flutter_ui_kit/views/user_profile/user_profile.dart';
import 'package:prime_social_media_flutter_ui_kit/views/widget/home/comments_bottom_sheet.dart';
import 'package:prime_social_media_flutter_ui_kit/views/widget/home/likes_bottom_sheet.dart';

class PostItem extends StatelessWidget {
  final PostModel socialPost;
  final VoidCallback onLike;
  final bool isLiked;
  final dynamic Function(String)? onReactionAdd;
  final dynamic Function(String)? onReactionRemove;
  final HomeController controller;
  final String reactionCount;
  final String commentsCount;

  const PostItem({
    Key? key,
    required this.socialPost,
    required this.onLike,
    required this.isLiked,
    this.onReactionAdd,
    this.onReactionRemove,
    required this.controller,
    required this.reactionCount,
    required this.commentsCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          left: AppSize.appSize20,
          right: AppSize.appSize20,
          bottom: AppSize.appSize40,
        ),
        child: socialPost.postImages == null || socialPost.postImages!.isEmpty
            ? _withoutpic(context)
            : _withPic(context));
  }

  bool _isVideo(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;

    final extension = uri.path.toLowerCase().split('.').last;
    return ['mp4', 'mov', 'avi', 'mkv', 'webm', 'm4v'].contains(extension);
  }

  _withPic(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPostHeader(languageController),
        _buildPostImage(context),
        if (socialPost.postImages == null || socialPost.postImages!.isEmpty)
          _buildPostDescription(),
        GetBuilder<HomeController>(
            id: "actions",
            builder: (cont) {
              return PostActions(
                reactionCount: reactionCount,
                comomentsCount: socialPost.commentsCount?.toString() ?? "",
                onComment: () async {
                  await commentsBottomSheet(
                      context, socialPost.postId.toString());
                },
                onReactionRemove: onReactionRemove,
                onReactionAdd: onReactionAdd,
                onLike: onLike,
                onLikesText: () => likesBottomSheet(context),
                // onShare: () => homeController.shareAssetImage(socialPost.i),
                isLiked: isLiked,
              );
            }),
        const CustomDivider(),
      ],
    );
  }

  _withoutpic(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPostHeader(languageController),
        //_buildPostImage(context),
        // if (socialPost.postImages == null || socialPost.postImages!.isEmpty)
        _buildPostDescription(),
        PostActions(
          comomentsCount: socialPost.commentsCount?.toString() ?? "",
          onComment: () async {
            commentsBottomSheet(context, socialPost.postId.toString());
          },
          onReactionRemove: onReactionRemove,
          onReactionAdd: onReactionAdd,
          onLike: onLike,
          onLikesText: () => likesBottomSheet(context),
          // onShare: () => homeController.shareAssetImage(socialPost.i),
          isLiked: isLiked,
        ),
        const CustomDivider(),
      ],
    );
  }

  Widget _buildPostHeader(LanguageController languageController) {
    final isRTL =
        languageController.selectedLanguageIndex.value == AppSize.size2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Get.to(UserProfile(
                userID: socialPost.userId,
              ));
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: isRTL ? 0 : 10,
                    left: isRTL ? 10 : 0,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: socialPost.photo!,
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        socialPost.name ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFont.appFontSemiBold,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                      Text(
                        socialPost.location ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: AppSize.appSize12,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.text2Color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 8,
                left: isRTL ? 8 : 0,
              ),
              child: Text(
                socialPost.createdAt ?? "",
                style: const TextStyle(
                  fontSize: AppSize.appSize14,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFont.appFontRegular,
                  color: AppColor.text1Color,
                ),
              ),
            ),
            Image.asset(
              AppIcon.more,
              width: 20,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPostImage(BuildContext context) {
    final images = socialPost.postImages;

    if (images == null || images.isEmpty) return const SizedBox.shrink();

    final totalImages = images.length;

    // ✅ Single media - take full width
    if (totalImages == 1) {
      return Padding(
        padding: const EdgeInsets.only(top: AppSize.appSize12),
        child: GestureDetector(
          onTap: () {
            if (_isVideo(images.first)) {
              Get.to(VideoPlayerScreen(
                videoUrl: images.first,
              ));
            } else {
              _openImageGallery(context, 0);
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: _buildMediaWidget(
              images[0],
              width: double.infinity,
              height: 250,
            ),
          ),
        ),
      );
    }

    // ✅ More than one media - use grid layout
    final displayImages = totalImages > 4 ? images.take(4).toList() : images;

    return Padding(
      padding: const EdgeInsets.only(top: AppSize.appSize12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: displayImages.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemBuilder: (gridContext, index) {
          final mediaUrl = displayImages[index];
          final isLastVisible = index == 3 && totalImages > 4;
          final extraCount = totalImages - 4;

          return GestureDetector(
            onTap: () {
              if (_isVideo(mediaUrl)) {
                Get.to(VideoPlayerScreen(
                  videoUrl: mediaUrl,
                ));
              } else {
                _openImageGallery(context, index);
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                _buildMediaWidget(mediaUrl),
                if (isLastVisible)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: Text(
                        '+$extraCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMediaWidget(String url, {double? width, double? height}) {
    if (_isVideo(url)) {
      return VideoPlayerWidget(
        videoUrl: url,
        width: width,
        height: height,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        width: width,
        height: height,
        errorWidget: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            child: const Center(
              child: Icon(
                Icons.broken_image,
                color: Colors.grey,
                size: 50,
              ),
            ),
          );
        },
      );
    }
  }

  void _openImageGallery(BuildContext context, int initialIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ImageGalleryScreen(
          images: socialPost.postImages!,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  Widget _buildPostDescription() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.appSize14),
      child: RichText(
        text: TextSpan(
          text: "",
          style: const TextStyle(
            fontSize: AppSize.appSize14,
            fontWeight: FontWeight.w700,
            fontFamily: AppFont.appFontBold,
            color: AppColor.secondaryColor,
          ),
          children: [
            TextSpan(
              text: socialPost.description,
              style: const TextStyle(
                fontSize: AppSize.appSize14,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontRegular,
                color: AppColor.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Video Player Widget
class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final double? width;
  final double? height;

  const VideoPlayerWidget({
    Key? key,
    required this.videoUrl,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
      }).catchError((error) {
        print('Video initialization error: $error');
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Container(
        width: widget.width,
        height: widget.height,
        color: Colors.grey[300],
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          // Play/Pause overlay
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          // Video indicator
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.videocam,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
