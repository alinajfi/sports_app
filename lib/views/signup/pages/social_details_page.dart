import 'package:flutter/material.dart';

class SocialDetailsPage extends StatefulWidget {
  const SocialDetailsPage({Key? key}) : super(key: key);

  @override
  State<SocialDetailsPage> createState() => _SocialDetailsPageState();
}

class _SocialDetailsPageState extends State<SocialDetailsPage> {
  final Map<String, TextEditingController> _controllers = {
    'Facebook': TextEditingController(text: '@adnan'),
    'Instagram': TextEditingController(text: '@adnan'),
    'TikTok': TextEditingController(text: '@adnan'),
    'X': TextEditingController(text: '@adnan'),
    'Twitter': TextEditingController(text: '@adnan'),
  };

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  IconData _getSocialIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'facebook':
        return Icons.facebook;
      case 'instagram':
        return Icons.camera_alt;
      case 'tiktok':
        return Icons.music_note;
      case 'x':
        return Icons.close;
      case 'twitter':
        return Icons.alternate_email;
      default:
        return Icons.public;
    }
  }

  Color _getSocialColor(String platform) {
    switch (platform.toLowerCase()) {
      case 'facebook':
        return const Color(0xFF1877F2);
      case 'instagram':
        return const Color(0xFFE4405F);
      case 'tiktok':
        return const Color(0xFF000000);
      case 'x':
        return const Color(0xFF000000);
      case 'twitter':
        return const Color(0xFF1DA1F2);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white70),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Add your Social Accounts',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Step 4 of 5',
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

            // Social Accounts List
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _controllers.entries.map((entry) {
                    final platform = entry.key;
                    final controller = entry.value;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Platform Label with Icon
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: _getSocialColor(platform)
                                      .withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _getSocialIcon(platform),
                                  color: _getSocialColor(platform),
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                platform,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Input Field
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(
                                  0xFF2C2C2C), // Dark input background
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey[600]!,
                                width: 1,
                              ),
                            ),
                            child: TextField(
                              controller: controller,
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
                                hintText: '@username',
                                hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                ),
                                suffixIcon: controller.text.isNotEmpty
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.clear,
                                          color: Colors.grey[400],
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            controller.clear();
                                          });
                                        },
                                      )
                                    : null,
                              ),
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Continue Button
            Container(
              width: double.infinity,
              height: 56,
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Handle continue action
                  final socialAccounts = <String, String>{};
                  _controllers.forEach((platform, controller) {
                    if (controller.text.isNotEmpty) {
                      socialAccounts[platform] = controller.text;
                    }
                  });
                  print('Social accounts: $socialAccounts');
                  // Add your navigation logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
