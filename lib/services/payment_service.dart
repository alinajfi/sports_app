// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:prime_social_media_flutter_ui_kit/utils/common_api_functions.dart';

// class PaymentService extends CommonApiFunctions {
//   // Future<String> createPaymentIntent() async {
//   //   final url = getUrlFromEndPoints(endPoint: "/create-payment-intent");
//   //   final response = await http.post(url);
//   //   final body = jsonDecode(response.body);
//   //   return body['clientSecret'];
//   // }

//   static const String stripeSecretKey =
//       'sk_test_51Joui7L1cSJT1UwBVD0ZcLVt3xPFpSXmbA30b9EJDCizXEFSpy4oQ4sbiyg5hsAJ4oMtLfiARPMdejVTaL4pjVQr00LJQMDtcD'; // ⚠️ DON'T use in production

//   Future<String> createPaymentIntent() async {
//     final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
//     final response = await http.post(
//       url,
//       headers: {
//         'Authorization': 'Bearer $stripeSecretKey',
//         'Content-Type': 'application/x-www-form-urlencoded',
//       },
//       body: {
//         'amount': '1000', // amount in cents
//         'currency': 'usd',
//         'payment_method_types[]': 'card',
//       },
//     );

//     final jsonResponse = jsonDecode(response.body);
//     return jsonResponse['client_secret'];
//   }
// }
