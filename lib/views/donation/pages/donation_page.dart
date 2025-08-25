import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prime_social_media_flutter_ui_kit/main.dart';
import 'package:prime_social_media_flutter_ui_kit/routes/app_routes.dart';
import 'package:prime_social_media_flutter_ui_kit/services/stripe_service.dart';
import 'package:prime_social_media_flutter_ui_kit/utils/widget_helper.dart';
import '../../../../config/app_color.dart';
import '../../home/home_view.dart'; // your AppColor dark theme class

class DonationScreen extends StatefulWidget {
  const DonationScreen({Key? key}) : super(key: key);

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  String selectedFrequency = 'Single';
  String selectedAmount = '£5';
  String customAmount = '';
  bool giftAidEnabled = true;

  final TextEditingController _customAmountController = TextEditingController();

  final List<String> frequencies = ['Single', 'Monthly'];
  final List<String> amounts = ['£5', '£10', '£15'];

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

            // Profile Name
            const Center(
              child: Text(
                'Profile Name',
                style: TextStyle(
                  color: AppColor.secondaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Frequency Selection
            _buildFrequencySelection(),
            const SizedBox(height: 24),

            // Amount Selection
            _buildAmountSelection(),
            const SizedBox(height: 24),

            // Gift Aid Featured Card
            _buildGiftAidCard(),
            const SizedBox(height: 24),

            // Administration Section
            const Text(
              'Administration',
              style: TextStyle(
                color: AppColor.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Gift Aid Option
            _buildGiftAidOption(),
            const SizedBox(height: 12),

            // What is Gift Aid Info
            _buildGiftAidInfo(),
            const SizedBox(height: 32),

            // Continue Button
            _buildContinueButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildFrequencySelection() {
    return Row(
      children: frequencies.map((frequency) {
        final isSelected = selectedFrequency == frequency;
        return Expanded(
          child: Container(
            margin:
                EdgeInsets.only(right: frequency != frequencies.last ? 12 : 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedFrequency = frequency;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.blue.shade600
                      : AppColor.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    frequency,
                    style: TextStyle(
                      color:
                          isSelected ? Colors.white : AppColor.secondaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAmountSelection() {
    return Column(
      children: [
        // Amount buttons
        Row(
          children: amounts.map((amount) {
            final isSelected = selectedAmount == amount && customAmount.isEmpty;
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: amount != amounts.last ? 12 : 0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAmount = amount;
                      customAmount = '';
                      _customAmountController.clear();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.blue.shade600
                          : AppColor.cardBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        amount,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColor.secondaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),

        // OR divider
        const Text(
          'OR',
          style: TextStyle(
            color: AppColor.text2Color,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),

        // Custom amount input
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: AppColor.cardBackgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.chatColor.withOpacity(0.3)),
          ),
          child: TextField(
            controller: _customAmountController,
            style: const TextStyle(color: AppColor.secondaryColor),
            decoration: const InputDecoration(
              hintText: 'Enter Amount Manually',
              hintStyle: TextStyle(color: AppColor.text2Color),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {
                customAmount = value;
                if (value.isNotEmpty) {
                  selectedAmount = '';
                }
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGiftAidCard() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Gradient background
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.cardBackgroundColor.withOpacity(0.1),
                      AppColor.cardBackgroundColor.withOpacity(0.9),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // Text content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Gift Aid Benefits',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: const [
                        Icon(Icons.location_on_outlined,
                            size: 14, color: Colors.white70),
                        SizedBox(width: 4),
                        Text(
                          'Available for UK taxpayers',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Icon(Icons.trending_up,
                            size: 14, color: Colors.white70),
                        SizedBox(width: 4),
                        Text(
                          'Increase donation by 25%',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(Icons.money_off, size: 14, color: Colors.white70),
                        SizedBox(width: 4),
                        Text(
                          'No cost',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGiftAidOption() {
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
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    giftAidEnabled = !giftAidEnabled;
                  });
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: giftAidEnabled ? Colors.green : Colors.transparent,
                    border: Border.all(
                      color:
                          giftAidEnabled ? Colors.green : AppColor.text2Color,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: giftAidEnabled
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enable Gift Aid',
                  style: TextStyle(
                    color: AppColor.secondaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Yes, I would like Gift Aid claimed on my donation.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGiftAidInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What is Gift Aid?',
            style: TextStyle(
              color: AppColor.secondaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'By allowing, my muslim burial to claim Gift Aid, you can increase the value of your donation by 25% at no cost to you. Your donation of £5 will be worth £6.25 without you spending an extra penny.',
            style: TextStyle(
              fontSize: 13,
              color: AppColor.text2Color,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            makePayment(context, onPaymentSuccess: () {
              WidgetHelper.showSnackBar(title: "Payment successfull");
              Future.delayed(const Duration(milliseconds: 500), () {
                int count = 0;
                Get.until((_) => count++ >= 3); // pops 3 screens
              });
            });
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade600,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Make Payment',
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
    _customAmountController.dispose();
    super.dispose();
  }

  Future<void> makePayment(BuildContext context,
      {Function? onPaymentSuccess}) async {
    try {
      log("Called make payment");
      final paymentIntent = await StripeService.createPaymentIntent(
        amount: '1000', // Amount in cents ($10.00)
        currency: 'usd',
      );
      log(paymentIntent['client_secret'].toString());
      // Initialize payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'Sport me',
          style: ThemeMode.light,
        ),
      );

      try {
        // Ensure we're on the main thread and UI is ready
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await Future.delayed(Duration(seconds: 1));

          await Stripe.instance.presentPaymentSheet(
            options: PaymentSheetPresentOptions(),
          );

          // Success handling
          if (context.mounted) {
            onPaymentSuccess?.call();
          }
        });
      } on StripeException catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Payment error: ${e.error.message}')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected error: $e')),
          );
        }
      }
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Payment successful!')),
      // );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed: $e')),
      );
    }
  }
}
