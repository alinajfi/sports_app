import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class ThirdPartyLoginService {
  // Future<UserCredential> signInWithFacebook() async {
  //   //final arr = [];

  //   final LoginResult result = await FacebookAuth.instance.login();
  //   final OAuthCredential credential =
  //       FacebookAuthProvider.credential(result.accessToken!.tokenString);
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  // Future<UserCredential> signInWithTwitter() async {
  //   final twitterLogin = TwitterLogin(
  //     apiKey: 'YOUR_API_KEY',
  //     apiSecretKey: 'YOUR_API_SECRET_KEY',
  //     redirectURI: 'YOUR_REDIRECT_URI',
  //   );
  //   final authResult = await twitterLogin.login();
  //   final OAuthCredential credential = TwitterAuthProvider.credential(
  //     accessToken: authResult.authToken!,
  //     secret: authResult.authTokenSecret!,
  //   );
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  Future<void> sendTokenToBackend(String idToken) async {
    final response = await http.post(
      Uri.parse('https://your-backend-api.com/verify-token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'idToken': idToken}),
    );
    if (response.statusCode == 200) {
      log('Token verified successfully');
    } else {
      log('Token verification failed');
    }
  }
}
