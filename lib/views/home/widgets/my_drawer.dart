import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/constants/db_constants.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/db_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/home/home_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
import 'package:prime_social_media_flutter_ui_kit/views/home/messages/messages_view.dart';
import 'package:prime_social_media_flutter_ui_kit/views/login/login_view.dart';

import '../../../controller/auth_controller.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Profile Picture
                    Container(
                      clipBehavior: Clip.hardEdge,
                      child: CachedNetworkImage(
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.person),
                        fit: BoxFit.fill,
                        imageUrl:
                            Get.find<AuthController>().currentUser?.photo ?? "",
                        placeholder: (context, url) =>
                            const Icon(Icons.person), // optional
                      ),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),

                    const SizedBox(height: 16),
                    // Name and Username
                    Text(
                      AuthController.instance.currentUser?.name ?? 'Guest',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AuthController.instance.currentUser?.name != null
                          ? '@${AuthController.instance.currentUser?.username}'
                          : '@adnanr',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // _buildStatItem(
                        //     AuthController.instance.currentUser?.name, 'Posts'),
                        _buildStatItem(
                            AuthController.instance.currentUser?.following
                                    .toString() ??
                                "0",
                            'Following'),
                        _buildStatItem(
                            AuthController.instance.currentUser?.followers
                                    .toString() ??
                                "0",
                            'Followers'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Menu Items
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      // _buildMenuItem(
                      //   icon: Icons.schedule,
                      //   title: 'Schedule Now',
                      //   badge: '12',
                      //   onTap: () {},
                      // ),
                      _buildMenuItem(
                        icon: Icons.group,
                        title: 'Friends',
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: "Comming soon",
                              gravity: ToastGravity.CENTER);
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.message,
                        title: 'Messages',
                        // badge: '',
                        highlighted: false,
                        onTap: () {
                          Get.toNamed(AppRoutes.messagesView);
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.account_balance_wallet,
                        title: 'Balance',
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: "Comming soon",
                              gravity: ToastGravity.CENTER);
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.share,
                        title: 'Share',
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: "Comming soon",
                              gravity: ToastGravity.CENTER);
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.qr_code,
                        title: 'QR Code',
                        // badge: '12',
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: "Comming soon",
                              gravity: ToastGravity.CENTER);
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.people,
                        title: 'Affiliates',
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: "Comming soon",
                              gravity: ToastGravity.CENTER);
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.notifications,
                        title: 'Notifications',
                        //badge: '99+',
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: "Comming soon",
                              gravity: ToastGravity.CENTER);
                        },
                      ),
                      // _buildMenuItem(
                      //   icon: Icons.groups,
                      //   title: 'Socials',
                      //   onTap: () {},
                      // ),
                      _buildMenuItem(
                        icon: Icons.supervised_user_circle,
                        title: 'Supervision',
                        // badge: '12',
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: "Comming soon",
                              gravity: ToastGravity.CENTER);
                        },
                      ),
                      // _buildMenuItem(
                      //   icon: Icons.description,
                      //   title: 'Terms & Conditions',
                      //   onTap: () {},
                      // ),
                      // _buildMenuItem(
                      //   icon: Icons.photo_album,
                      //   title: 'Albums',
                      //   onTap: () {},
                      // ),
                      // _buildMenuItem(
                      //   icon: Icons.favorite,
                      //   title: 'Favorites',
                      //   onTap: () {},
                      // ),
                      const SizedBox(height: 20),
                      _buildMenuItem(
                        icon: Icons.delete,
                        title: 'Delete Account',
                        textColor: Colors.red,
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.logout,
                        title: 'Logout',
                        textColor: Colors.red,
                        onTap: () {
                          log("-----logout tapped");
                          DbController.instance
                              .writeData(DbConstants.isUserLoggedIn, null);
                          DbController.instance
                              .writeData(DbConstants.apiToken, null);
                          AuthController.instance.currentUser = null;
                          Get.delete<HomeController>();
                          Get.off(LoginView());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? badge,
    bool highlighted = false,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: highlighted ? Colors.blue[900] : Colors.transparent,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: highlighted ? Colors.blue : Colors.grey[800],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(
            icon,
            color: highlighted ? Colors.white : Colors.grey[400],
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor ?? Colors.white,
          ),
        ),
        trailing: badge != null
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
        onTap: onTap,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      ),
    );
  }
}
