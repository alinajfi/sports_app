import 'package:flutter/material.dart';
import '../../../config/app_color.dart';

class SupportersScreen extends StatelessWidget {
  const SupportersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Supporters',
          style: TextStyle(
            color: AppColor.secondaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios, color: AppColor.secondaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.more_vert, color: AppColor.secondaryColor),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Follower & Supporters Summary
            Row(
              children: [
                _buildSummaryCard('TOTAL FOLLOWERS', '29,432'),
                const SizedBox(width: 12),
                _buildSummaryCard('TOTAL SUPPORTERS', '12,853'),
              ],
            ),
            const SizedBox(height: 24),

            const Text(
              'Supporters List',
              style: TextStyle(
                color: AppColor.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            // List
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (_, index) {
                  final supporterNames = [
                    'Fleece Marigold',
                    'Druid Wensleydale',
                    'Cecil Hipplington'
                  ];
                  final countries = ['Germany', 'France', 'USA'];

                  return _buildSupporterCard(
                    name: supporterNames[index % 3],
                    country: countries[index % 3],
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // See All Button
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'SEE ALL',
                    style: TextStyle(
                      color: AppColor.secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String count) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AppColor.cardBackgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColor.text2Color,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              count,
              style: const TextStyle(
                color: AppColor.secondaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupporterCard({required String name, required String country}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColor.cardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Profile Placeholder
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColor.chatColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: AppColor.secondaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  country,
                  style: const TextStyle(
                    color: AppColor.text2Color,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // VIEW Button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text(
              'VIEW',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
