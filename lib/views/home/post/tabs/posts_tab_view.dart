// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/home/all_post_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/utils/widget_helper.dart';
import 'package:prime_social_media_flutter_ui_kit/views/widget/home/post_view_dailog.dart';
import '../../../../config/app_size.dart';

class PostsTabView extends StatelessWidget {
  PostsTabView({Key? key}) : super(key: key);

  AllPostController allPostController = Get.put(AllPostController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.appSize20,
        right: AppSize.appSize20,
      ),
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: AppSize.size4,
          crossAxisSpacing: AppSize.appSize1,
          mainAxisSpacing: AppSize.appSize1,
        ),
        itemCount: allPostController.postsList.length,
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                barrierColor: AppColor.backgroundColor
                    .withAlpha(AppSize.appSizePoint7.toInt()),
                builder: (context) {
                  WidgetHelper.showSnackBar(
                      title: "this is naviatyion form proifile");
                  return SizedBox();
                  // return PostViewDialog(
                  //     imageUrl: allPostController.postsList[index]);
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(allPostController.postsList[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
