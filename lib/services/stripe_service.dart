import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeService {
  static const String _secretKey =
      "sk_test_51Joui7L1cSJT1UwBVD0ZcLVt3xPFpSXmbA30b9EJDCizXEFSpy4oQ4sbiyg5hsAJ4oMtLfiARPMdejVTaL4pjVQr00LJQMDtcD";
  static const String _baseUrl = "https://api.stripe.com/v1";

  static Future<Map<String, dynamic>> createPaymentIntent({
    required String amount,
    required String currency,
  }) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('$_baseUrl/payment_intents'),
        headers: {
          'Authorization': 'Bearer $_secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );

      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<void> makePayment(BuildContext context,
      {Function? onPaymentSuccess}) async {
    try {
      // Create payment intent
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
          await Future.delayed(Duration(milliseconds: 800));

          await Stripe.instance.presentPaymentSheet(
            options: PaymentSheetPresentOptions(),
          );

          // Success handling
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payment successful!')),
            );
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment successful!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed: $e')),
      );
    }
  }
}
