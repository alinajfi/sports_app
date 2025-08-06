// ignore_for_file: public_member_api_docs, sort_constructors_first
// shared/post_actions.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_font.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_icon.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/settings_options/language_controller.dart';

class PostActions extends StatefulWidget {
  final VoidCallback? onComment;
  final VoidCallback onLike;
  final VoidCallback? onLikesText;
  final VoidCallback? onShare;
  final Function(String)? onReactionAdd;
  final Function(String)? onReactionRemove;
  final bool isLiked;
  final Map<String, int>? reactions; // Map of emoji -> count
  final String? userReaction; // Current user's reaction
  final String comomentsCount;

  const PostActions({
    Key? key,
    this.onComment,
    required this.onLike,
    this.onLikesText,
    this.onShare,
    this.onReactionAdd,
    this.onReactionRemove,
    required this.isLiked,
    this.reactions,
    this.userReaction,
    required this.comomentsCount,
  }) : super(key: key);

  @override
  State<PostActions> createState() => _PostActionsState();
}

class _PostActionsState extends State<PostActions> {
  final GlobalKey _reactionButtonKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isReactionPickerVisible = false;

  // Available reactions
  // final List<String> _availableReactions = [
  //   '❤️',
  // ];

  @override
  void dispose() {
    _removeReactionPicker();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 14.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Comment section - Flexible to prevent overflow
          if (widget.onComment != null)
            _buildActionButton(
              AppIcon.comment,
              22.0,
              AppString.comment10k,
              widget.onComment!,
              widget.onComment,
            ),

          // Like section - Flexible to prevent overflow
          Obx(() => _buildActionButton(
                widget.isLiked ? AppIcon.like : AppIcon.emptyLike,
                26.0,
                AppString.likes55k,
                widget.onLike,
                widget.onLikesText,
              )),

          // Share section - Flexible to prevent overflow
          if (widget.onShare != null)
            Expanded(
              flex: 2,
              child: _buildActionButton(
                AppIcon.share,
                22.0,
                AppString.share5k,
                widget.onShare!,
              ),
            ),

          // Reaction section - Fixed width to prevent layout issues
          // SizedBox(
          //   width: 100,
          //   child: _buildReactionButton(),
          // ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String icon,
    double width,
    String text,
    VoidCallback onTap, [
    VoidCallback? onTapText,
  ]) {
    final languageController = Get.find<LanguageController>();

    return Container(
      constraints: const BoxConstraints(minWidth: 0), // Prevent overflow
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: languageController.selectedLanguageIndex.value == 2
                  ? 0.0
                  : 6.0,
              left: languageController.selectedLanguageIndex.value == 2
                  ? 6.0
                  : 0.0,
            ),
            child: GestureDetector(
              onTap: onTap,
              child: Image.asset(
                icon,
                width: width,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback icon if image fails to load
                  return Icon(
                    Icons.favorite_border,
                    size: width,
                    color: AppColor.secondaryColor,
                  );
                },
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: onTapText ?? onTap,
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFont.appFontSemiBold,
                  color: AppColor.secondaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildReactionButton() {
  //   final reactions = widget.reactions ?? {};
  //   final totalReactions =
  //       reactions.values.fold(0, (sum, count) => sum + count);
  //   final topReactions = _getTopReactions(reactions, 3);

  //   return GestureDetector(
  //     key: _reactionButtonKey,
  //     onTap: _showReactionPicker,
  //     onLongPress: _showReactionPicker,
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(
  //         horizontal: 8.0,
  //         vertical: 4.0,
  //       ),
  //       decoration: BoxDecoration(
  //         color: widget.userReaction != null
  //             ? AppColor.primaryColor.withOpacity(0.1)
  //             : AppColor.backgroundColor,
  //         borderRadius: BorderRadius.circular(20.0),
  //         border: Border.all(
  //           color: widget.userReaction != null
  //               ? AppColor.primaryColor.withOpacity(0.3)
  //               : AppColor.lineColor,
  //           width: 1.0,
  //         ),
  //       ),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           if (topReactions.isNotEmpty) ...[
  //             // Show top reactions with proper constraints
  //             Container(
  //               width: 40.0,
  //               height: 20.0,
  //               child: Stack(
  //                 clipBehavior: Clip.none,
  //                 children: topReactions.asMap().entries.map((entry) {
  //                   int index = entry.key;
  //                   String emoji = entry.value;
  //                   return Positioned(
  //                     left: index * 12.0,
  //                     child: _buildReactionEmoji(emoji),
  //                   );
  //                 }).toList(),
  //               ),
  //             ),
  //             const SizedBox(width: 4.0),
  //           ] else ...[
  //             // Show default reaction icon when no reactions
  //             const Icon(
  //               Icons.add_reaction_outlined,
  //               size: 18.0,
  //               color: AppColor.secondaryColor,
  //             ),
  //             const SizedBox(width: 4.0),
  //           ],
  //           // Flexible(
  //           //   child: Text(
  //           //     totalReactions > 0 ? _formatCount(totalReactions) : 'React',
  //           //     style: TextStyle(
  //           //       fontSize: 12.0,
  //           //       fontWeight: FontWeight.w600,
  //           //       fontFamily: AppFont.appFontSemiBold,
  //           //       color: widget.userReaction != null
  //           //           ? AppColor.primaryColor
  //           //           : AppColor.secondaryColor,
  //           //     ),
  //           //     maxLines: 1,
  //           //     overflow: TextOverflow.ellipsis,
  //           //   ),
  //           // ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildReactionEmoji(String emoji) {
    return Container(
      width: 16.0,
      height: 16.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2.0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: Text(
          emoji,
          style: const TextStyle(
            fontSize: 10.0,
          ),
        ),
      ),
    );
  }

  List<String> _getTopReactions(Map<String, int> reactions, int limit) {
    var sortedReactions = reactions.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sortedReactions.take(limit).map((e) => e.key).toList();
  }

  // String _formatCount(int count) {
  //   if (count >= 1000000) {
  //     return '${(count / 1000000).toStringAsFixed(1)}M';
  //   } else if (count >= 1000) {
  //     return '${(count / 1000).toStringAsFixed(1)}k';
  //   }
  //   return count.toString();
  // }

  void _showReactionPicker() {
    if (_isReactionPickerVisible) {
      _removeReactionPicker();
      return;
    }

    final RenderBox? renderBox =
        _reactionButtonKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenSize = MediaQuery.of(context).size;

    // Calculate position to ensure picker stays on screen
    double left = position.dx - 50;
    double top = position.dy - 70;

    // Adjust if picker would go off screen
    if (left < 10) left = 10;
    if (left + 300 > screenSize.width) left = screenSize.width - 310;
    if (top < 50) top = position.dy + size.height + 10;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Transparent barrier to close picker
          GestureDetector(
            onTap: _removeReactionPicker,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            ),
          ),
          // Reaction picker
          Positioned(
            left: left,
            top: top,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(25.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                // child: Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: _availableReactions.map((emoji) {
                //     final isSelected = widget.userReaction == emoji;
                //     return GestureDetector(
                //       onTap: () => _onReactionTap(emoji),
                //       child: Container(
                //         margin: const EdgeInsets.symmetric(horizontal: 2),
                //         padding: const EdgeInsets.all(8.0),
                //         decoration: BoxDecoration(
                //           shape: BoxShape.circle,
                //           color: isSelected
                //               ? AppColor.primaryColor.withOpacity(0.2)
                //               : Colors.transparent,
                //         ),
                //         child: Text(
                //           emoji,
                //           style: const TextStyle(
                //             fontSize: 20.0,
                //           ),
                //         ),
                //       ),
                //     );
                //   }).toList(),
                // ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isReactionPickerVisible = true;
  }

  void _removeReactionPicker() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _isReactionPickerVisible = false;
    }
  }

  void _onReactionTap(String emoji) {
    _removeReactionPicker();

    if (widget.userReaction == emoji) {
      // Remove reaction if same emoji is tapped
      widget.onReactionRemove?.call(emoji);
    } else {
      // Add new reaction or change existing one
      if (widget.userReaction != null) {
        widget.onReactionRemove?.call(widget.userReaction!);
      }
      widget.onReactionAdd?.call(emoji);
    }
  }
}

// shared/custom_divider.dart
class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColor.lineColor,
      height: 0.0,
    );
  }
}

// Example usage:
/*
class ExamplePostWidget extends StatefulWidget {
  @override
  _ExamplePostWidgetState createState() => _ExamplePostWidgetState();
}

class _ExamplePostWidgetState extends State<ExamplePostWidget> {
  RxBool isLiked = false.obs;
  Map<String, int> reactions = {'👍': 5, '❤️': 3, '😍': 2};
  String? userReaction;

  @override
  Widget build(BuildContext context) {
    return PostActions(
      onComment: () => print('Comment tapped'),
      onLike: () => isLiked.toggle(),
      onShare: () => print('Share tapped'),
      onReactionAdd: (emoji) {
        setState(() {
          userReaction = emoji;
          reactions[emoji] = (reactions[emoji] ?? 0) + 1;
        });
      },
      onReactionRemove: (emoji) {
        setState(() {
          if (userReaction == emoji) {
            userReaction = null;
          }
          if (reactions[emoji] != null) {
            reactions[emoji] = reactions[emoji]! - 1;
            if (reactions[emoji]! <= 0) {
              reactions.remove(emoji);
            }
          }
        });
      },
      isLiked: isLiked,
      reactions: reactions,
      userReaction: userReaction,
    );
  }
}
*/