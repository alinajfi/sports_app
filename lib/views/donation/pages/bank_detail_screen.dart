import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
import 'package:prime_social_media_flutter_ui_kit/views/donation/pages/payment_summary_screen.dart';
import '../../../config/app_color.dart'; // your AppColor dark theme class

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final TextEditingController _accountNameController =
      TextEditingController(text: 'Benjamin Exalent');
  final TextEditingController _accountNumberController =
      TextEditingController(text: '1234 1234');
  final TextEditingController _sortCodeController =
      TextEditingController(text: '454567');
  final TextEditingController _postCodeController = TextEditingController();
  String selectedDonationDay = '1st Day of the Month';

  final List<String> donationDays = [
    '1st Day of the Month',
    '15th Day of the Month',
    'Last Day of the Month',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // Donation Summary Header
            const Text(
              'Donation Summary',
              style: TextStyle(
                color: AppColor.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Payment Amount Card
            _buildPaymentSummaryCard(),
            const SizedBox(height: 24),

            // Bank Details Section
            const Text(
              'Bank Details',
              style: TextStyle(
                color: AppColor.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _buildBankDetailsForm(),
            const SizedBox(height: 24),

            // Monthly Donation Section
            const Text(
              'Monthly Donation',
              style: TextStyle(
                color: AppColor.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _buildMonthlyDonationCard(),
            const SizedBox(height: 32),

            // Confirm Payment Button
            _buildConfirmButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColor.chatColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(
                Icons.account_balance,
                color: AppColor.secondaryColor,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '£5 Single Payment',
                  style: TextStyle(
                    color: AppColor.secondaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Icon(Icons.schedule, size: 14, color: AppColor.text2Color),
                    SizedBox(width: 4),
                    Text(
                      'Monthly recurring donation',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.text2Color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(Icons.account_balance_wallet,
                        size: 14, color: AppColor.text2Color),
                    SizedBox(width: 4),
                    Text(
                      'Direct Debit setup',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetailsForm() {
    return Column(
      children: [
        // Account Name
        _buildFormField(
          label: 'Account Name',
          controller: _accountNameController,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 16),

        // Account Number
        _buildFormField(
          label: 'Account Number',
          controller: _accountNumberController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),

        // Sort Code
        _buildFormField(
          label: 'Sort Code',
          controller: _sortCodeController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),

        // Address Post Code
        _buildFormField(
          label: 'Address Post Code',
          controller: _postCodeController,
          keyboardType: TextInputType.text,
          hintText: 'Start typing your post code and choose from the list',
        ),
      ],
    );
  }

  Widget _buildMonthlyDonationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColor.chatColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(
                    Icons.calendar_today,
                    color: AppColor.secondaryColor,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'When would you like to donate each month?',
                      style: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Dropdown for donation day
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: AppColor.chatColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.chatColor.withOpacity(0.5)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedDonationDay,
                isExpanded: true,
                dropdownColor: AppColor.cardBackgroundColor,
                style: const TextStyle(
                  color: AppColor.secondaryColor,
                  fontSize: 14,
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedDonationDay = newValue;
                    });
                  }
                },
                items:
                    donationDays.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(value),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColor.secondaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: AppColor.chatColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.chatColor.withOpacity(0.5)),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(color: AppColor.secondaryColor),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColor.text2Color,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Handle payment confirmation
          Get.toNamed(AppRoutes.thankYouScreen);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade600,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'CONFIRM PAYMENT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    _accountNumberController.dispose();
    _sortCodeController.dispose();
    _postCodeController.dispose();
    super.dispose();
  }
}
