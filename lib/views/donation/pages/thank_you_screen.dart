import 'package:flutter/material.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios, color: AppColor.secondaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'SUPPORTER',
          style: TextStyle(
            color: AppColor.text2Color,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon:
                const Icon(Icons.mail_outline, color: AppColor.secondaryColor),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: AppColor.secondaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.handshake_outlined, // Placeholder icon
                size: 80,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 32),
              const Text(
                'Thank you\nfor support',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to donation page or desired screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'MAKE ANOTHER DONATION',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextButton.icon(
                onPressed: () {
                  // TODO: Share logic
                },
                icon: const Icon(Icons.ios_share_outlined,
                    color: Colors.white70, size: 20),
                label: const Text(
                  'Share to social',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
