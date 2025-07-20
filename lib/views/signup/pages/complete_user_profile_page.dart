import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/sign_up_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _usernameController =
      TextEditingController(text: '@adnan');
  final TextEditingController _bioController = TextEditingController(
    text:
        'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum',
  );
  final TextEditingController _affiliateController =
      TextEditingController(text: '223876F2');

  bool _isUsernameAvailable = true;
  String _profileName = 'Adnan R';

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    _affiliateController.dispose();
    super.dispose();
  }

  void _checkUsernameAvailability(String username) {
    setState(() {
      _isUsernameAvailable = username.isNotEmpty && username != '@taken';
    });
  }

  void _pickProfileImage() {
    // Handle profile image selection
    print('Pick profile image');
  }

  final signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white70),
            onPressed: () => signUpController.pageController.jumpToPage(4)
            // Navigator.of(context).pop(),
            ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Complete Profile',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Step 5 of 5',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),

            // Progress Bar
            Container(
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.pink, Colors.purple],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Description Text
            const Text(
              'By creating a distinctive username and adding an engaging profile picture, you\'ll leave a lasting impression in the online community.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),

            // Profile Picture Section
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF2C2C2C),
                      border: Border.all(
                        color: Colors.grey[600]!,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickProfileImage,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Profile Name
            Center(
              child: Text(
                _profileName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Username Section
            const Text(
              'Username',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isUsernameAvailable ? Colors.grey[600]! : Colors.red,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _usernameController,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  hintText: '@username',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                onChanged: _checkUsernameAvailability,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _isUsernameAvailable
                  ? 'Username Available!'
                  : 'Username not available',
              style: TextStyle(
                fontSize: 14,
                color: _isUsernameAvailable ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),

            // Bio Section
            const Text(
              'Bio',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey[600]!,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _bioController,
                maxLines: 4,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16),
                  border: InputBorder.none,
                  hintText: 'Tell us about yourself...',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Affiliate Code Section
            const Text(
              'Affiliate Code (If provided by an agent)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey[600]!,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _affiliateController,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  hintText: 'Enter affiliate code',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Create Profile Button
            Container(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Handle profile creation
                  final profileData = {
                    'username': _usernameController.text,
                    'bio': _bioController.text,
                    'affiliateCode': _affiliateController.text,
                    'profileName': _profileName,
                  };
                  print('Profile data: $profileData');
                  // Add your profile creation logic here
                  Get.toNamed(AppRoutes.welcomeView);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Create Profile',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
