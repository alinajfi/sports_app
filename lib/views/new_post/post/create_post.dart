import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/create_post_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/model/create_post_model.dart';
import 'package:video_player/video_player.dart';

import '../../../controller/auth_controller.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  dispose() {
    Get.delete<CreatePostController>();
    super.dispose();
  }

  final CreatePostController controller = Get.put(CreatePostController());

  final List<IconData> postIcons = [
    Icons.image_outlined,
    Icons.person_add_alt_1_outlined,
    Icons.emoji_emotions_outlined,
    Icons.location_on_outlined,
    Icons.event_outlined,
  ];

  final List<String> privacyOptions = ['Public', 'Friends', 'Only me'];

  final Color darkBackground = const Color(0xFF121212);

  final Color darkCard = const Color(0xFF1E1E1E);

  final Color primaryText = Colors.white;

  final Color secondaryText = Colors.grey;

  final Color iconColor = Colors.purpleAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: darkBackground,
        elevation: 1,
        title: Text(
          'Create Post',
          style: TextStyle(
            color: primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close, color: primaryText),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: MediaQuery.of(context).viewInsets.bottom > 0
              ? BouncingScrollPhysics()
              : NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _userRow(),
              const SizedBox(height: 12),
              _descriptionField(),
              const SizedBox(height: 12),
              Text(
                "Add to your post",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: primaryText,
                ),
              ),
              const SizedBox(height: 8),
              _iconRow(),
              GetBuilder<CreatePostController>(
                id: "image_or_vid_container",
                builder: (controller) {
                  if (controller.pickedFiles.isNotEmpty) {
                    return Container(
                      height: 200,
                      width: MediaQuery.sizeOf(context).width,
                      child: FilePreview(
                        file: controller.pickedFiles.first,
                      ),
                    );
                  }

                  if (controller.pickedImages.isNotEmpty) {
                    return SizedBox(
                      height: 230,
                      child: GridView.builder(
                        itemCount: controller.pickedImages.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1,
                        ),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final imageFile = controller.pickedImages[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              imageFile,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _publishButton(context),
    );
  }

  Widget _iconRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _iconButton(
          Icons.image_outlined,
          'Image',
          () async {
            controller.isVideo = false;
            await controller.pickImages();
            controller.pickedFiles.value = [];
            controller.update(['image_or_vid_container']);
          },
        ),
        _iconButton(
            Icons.person_add_alt_1_outlined, 'Tag', controller.tagPeople),
        _iconButton(
            Icons.location_on_outlined, 'Location', controller.pickLocation),
        _iconButton(Icons.video_camera_front, 'Video', () async {
          log("called");
          controller.isVideo = true;
          await controller.pickVideoFiles();
          controller.pickedImages.value = [];
          controller.update(['image_or_vid_container']);
        }),
      ],
    );
  }

  Widget _iconButton(IconData icon, String tooltip, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: tooltip,
        child: CircleAvatar(
          backgroundColor: const Color(0xFF1E1E1E),
          radius: 22,
          child: Icon(icon, color: Colors.purpleAccent, size: 22),
        ),
      ),
    );
  }

  Widget _userRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: AuthController.instance.currentUser?.photo != null
              ? CachedNetworkImageProvider(
                  AuthController.instance.currentUser!.photo,
                )
              : const AssetImage('assets/images/profile_placeholder.png')
                  as ImageProvider,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<CreatePostController>(
                id: "user_name",
                builder: (_) {
                  return Text(
                    Get.find<AuthController>().currentUser?.name ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primaryText,
                    ),
                  );
                }),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: darkCard,
                value: privacyOptions[0],
                icon: Icon(Icons.arrow_drop_down, color: secondaryText),
                items: privacyOptions
                    .map((option) => DropdownMenuItem(
                          value: option,
                          child: Row(
                            children: [
                              Icon(
                                option == 'Public'
                                    ? Icons.public
                                    : option == 'Friends'
                                        ? Icons.group
                                        : Icons.lock,
                                size: 18,
                                color: secondaryText,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                option,
                                style: TextStyle(color: secondaryText),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _descriptionField() {
    return TextFormField(
      controller: controller.descriptionController,
      maxLines: 6,
      style: TextStyle(color: primaryText),
      decoration: InputDecoration(
        hintText: "What's on your mind Adeel Abbasi?",
        hintStyle: TextStyle(
          fontSize: 18,
          color: secondaryText,
        ),
        border: InputBorder.none,
      ),
    );
  }

  Widget _publishButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
        ),
        onPressed: () async {
          try {
            await controller.uploadPost(CreatePostModel(
                multipleFiles: controller.isVideo!
                    ? controller.pickedFiles.value
                        .map((file) => File(file.path!))
                        .toList()
                    : controller.pickedImages
                        .map((file) => File(file.path))
                        .toList(),
                privacy: "public",
                description: controller.descriptionController.text));
            Fluttertoast.showToast(msg: "Post uploaded");
            Get.back(result: true);
          } catch (e) {
            Fluttertoast.showToast(msg: "Post $e");
          }
        },
        child: Obx(() => controller.isLoading.value
            ? CircularProgressIndicator.adaptive()
            : Text(
                'Publish Now',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )),
      ),
    );
  }
}

class FilePreview extends StatefulWidget {
  final PlatformFile file;
  const FilePreview({Key? key, required this.file}) : super(key: key);

  @override
  State<FilePreview> createState() => _FilePreviewState();
}

class _FilePreviewState extends State<FilePreview> {
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();

    final ext = widget.file.extension?.toLowerCase();
    if (ext == "mp4" || ext == "mov" || ext == "avi" || ext == "mkv") {
      _videoController = VideoPlayerController.file(
        File(widget.file.path!),
      )..initialize().then((_) {
          setState(() {}); // refresh after init
          _videoController?.play(); // auto play (optional)
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ext = widget.file.extension?.toLowerCase();

    return SizedBox(
      height: 230,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ext == "jpg" || ext == "jpeg" || ext == "png"
            ? Image.file(
                File(widget.file.path!),
                fit: BoxFit.cover,
              )
            : (_videoController != null &&
                    _videoController!.value.isInitialized)
                ? AspectRatio(
                    aspectRatio: _videoController!.value.aspectRatio,
                    child: VideoPlayer(_videoController!),
                  )
                : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
