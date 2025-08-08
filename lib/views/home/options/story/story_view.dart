// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:story_view/story_view.dart';

import '../../../../model/story_model.dart';

class StoryFullView extends StatelessWidget {
  final StoryModel story;
  final StoryController controller = StoryController();

  StoryFullView({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: _buildStoryView(),
      ),
    );
  }

  Widget _buildStoryView() {
    final List<StoryItem> storyItems = [
      StoryItem.inlineImage(
        url: story.postImages,
        controller: controller,
        roundedTop: false,
      ),
    ];

    return StoryView(
      storyItems: storyItems,
      controller: controller,
      inline: true,
      repeat: false,
      progressPosition: ProgressPosition.top,
      onComplete: () => Get.back(),
      onVerticalSwipeComplete: (direction) {
        if (direction == Direction.down) {
          Get.back();
        }
      },
    );
  }
}
