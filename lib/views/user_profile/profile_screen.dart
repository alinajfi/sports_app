import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
import '../../../config/app_color.dart'; // Make sure to import your color config

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Premium Subscription Card
                  _buildPremiumCard(),

                  const SizedBox(height: 30),

                  const Text(
                    'Following Bundles',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColor.secondaryColor,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Bundle Cards
                  Row(
                    children: [
                      Expanded(
                          child: _buildBundleCard(
                              '5% OFF', '£24.90', 'for 3 months')),
                      const SizedBox(width: 16),
                      Expanded(
                          child: _buildBundleCard(
                              '10% OFF', '£36.90', 'for 6 months')),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Additional Premium Cards
                  _buildPremiumCard(),
                  const SizedBox(height: 20),
                  _buildPremiumCard(),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColor.chatColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              Icons.diamond_outlined,
              color: AppColor.text2Color,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Premium Subscriptions',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.text2Color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: '£2.50',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                      TextSpan(
                        text: ' / monthly',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.text2Color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              // Handle premium support button tap
              // print("Premium SUPPORT button tapped");
              // Get.to(SomeSupportPage()); // Example navigation
              Get.toNamed(AppRoutes.donationScreen);
            },
            borderRadius: BorderRadius.circular(25),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Text(
                'SUPPORT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBundleCard(String discount, String price, String duration) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColor.chatColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              discount,
              style: const TextStyle(
                color: Color(
                    0xFF4CAF50), // You can replace with a dark green if needed
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            price,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColor.secondaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            duration,
            style: const TextStyle(
              fontSize: 14,
              color: AppColor.text2Color,
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              // Handle bundle support button tap
              // print("Bundle SUPPORT button tapped");
              // Get.to(SomeSupportPage()); // Example navigation
              Get.toNamed(AppRoutes.donationScreen);
            },
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Text(
                'SUPPORT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
