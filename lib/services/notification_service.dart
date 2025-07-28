import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// Initialize local notifications
  Future<void> initializeLocalNotifications() async {
    // Android initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization settings
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        log('Local notification tapped: ${response.payload}');
        // Handle notification tap here
        _handleNotificationTap(response);
      },
    );

    // Request permissions for local notifications on iOS
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    // Request permissions for Android 13+
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  /// Handle notification tap
  void _handleNotificationTap(NotificationResponse response) {
    // Implement your navigation logic here
    log('Notification tapped with payload: ${response.payload}');

    // Example: Parse payload and navigate to specific screen
    if (response.payload != null) {
      final Map<String, dynamic> data = jsonDecode(response.payload!);
      // Navigate based on data
      // Example: Get.toNamed(data['route'], arguments: data['arguments']);
    }
  }

  /// Show local notification
  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    String? channelId,
    String? channelName,
    String? channelDescription,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'high_importance_channel', // channel id
      'High Importance Notifications', // channel name
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      enableVibration: true,
      playSound: true,
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await _localNotifications.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  /// Request notification permissions and register FCM token
  Future<void> requestPermissions() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    if (await Permission.notification.isGranted) {
      final token = await FirebaseMessaging.instance.getToken();
      log("FCM Token: $token");

      // Save token to Firestore (example, assuming user is logged in)
      // Replace this with your actual user logic
      // if (AuthController.instance.user != null) {
      //   await FirebaseFirestore.instance
      //       .collection('user')
      //       .doc("${AuthController.instance.user!.name}${AuthController.instance.user!.id}")
      //       .set({'fcmtoken': token});
      // }
    } else {
      log("Notification permission blocked");
    }
  }

  /// Listen for incoming foreground FCM messages and show local notifications
  Future<void> initialize() async {
    log("FCM listener initialized");

    // Initialize local notifications first
    await initializeLocalNotifications();

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('Foreground message received: ${message.notification?.title}');

      // Show local notification when app is in foreground
      if (message.notification != null) {
        await showLocalNotification(
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          title: message.notification!.title ?? 'New Notification',
          body: message.notification!.body ?? '',
          payload: jsonEncode(message.data), // Pass FCM data as payload
        );
      }
    });

    // Handle notification opened app (when app was terminated)
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        log('App opened from terminated state via notification: ${message.notification?.title}');
        _handleFCMNotificationTap(message);
      }
    });

    // Handle notification opened app (when app was in background)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('App opened from background via notification: ${message.notification?.title}');
      _handleFCMNotificationTap(message);
    });
  }

  /// Handle FCM notification tap
  void _handleFCMNotificationTap(RemoteMessage message) {
    // Implement your navigation logic here based on FCM data
    log('FCM notification tapped with data: ${message.data}');

    // Example navigation based on message data
    // if (message.data.containsKey('screen')) {
    //   Get.toNamed(message.data['screen']);
    // }
  }

  /// Show big text local notification
  Future<void> showBigTextNotification({
    required int id,
    required String title,
    required String body,
    required String bigText,
    String? payload,
  }) async {
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'big_text_channel',
      'Big Text Notifications',
      channelDescription: 'Channel for notifications with big text',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(
        bigText,
        contentTitle: title,
        summaryText: 'Summary',
      ),
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await _localNotifications.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  /// Show scheduled local notification
  Future<void> showScheduledNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDateTime,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'scheduled_channel',
      'Scheduled Notifications',
      channelDescription: 'Channel for scheduled notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    // await _localNotifications.zonedSchedule(
    //   id,
    //   title,
    //   body,
    //   scheduledDateTime,
    //   notificationDetails,
    //   payload: payload,
    //   uiLocalNotificationDateInterpretation:
    //   UILocalNotificationDateInterpretation.absoluteTime,
    // );
  }

  /// Cancel a specific notification
  Future<void> cancelNotification(int id) async {
    await _localNotifications.cancel(id);
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
  }

  /// Get OAuth2 access token from service account credentials
  Future<String> getAccessToken() async {
    const serviceAccountJson = {
      "type": "service_account",
      "project_id": "sportme-e47cd",
      "private_key_id": "9b990729372b066ea72f779ddf6e74ff60c9940e",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCmY7gJTE6RSZyV\n0u/RgSXWtsmgAvMR0Xt+CWHXdWNJ1/Ma0HaWqKIlA+0tx8MGs3sJM+moOX06yv57\nldc02nDzTkOOpnNZDSkppmL3pjU66xM+MXKuIeNOjikdJjaODaCcAkvQiwTEFndN\ndeWu2baIi3EwKgVg0j2Chrx4E2Wojbi/5M9+csa98GsJqTr0rcH2HsbLZWcu3ilZ\neAMe1T1DB5+5arp/ZuajCFxYYXJPKAyT+gtRVCrU9YU3/LRAcaZJFetlpE5NhF8P\nFkNK4i8oXDuhWNbk250okyQqc/M71mM5QtYkFC8XUB8uKggdRSoknxajSH+MrvMJ\n99Kzy239AgMBAAECgf86l8l3FlsuG0rI3j8VYVh+nZLi7I1fX1iqSYnq4nht+8RG\nhqJvUdlhFfQWHjWcM0stMnRVvE9QWBH4wAtiavB1I/PzIZDJ1/8Aa72699l6DGeT\n8lXJr3IcRHOCw37yoMBHyYc19b6RgfFnlaml3FHEqiLYLMDRsTd35eD4mw8+Pn8B\nLNa0UwJ5tQWBuPw+HG9ySmyQ3dNx6xYnu12PEPnLiQggEqi8nJTnW998kxgpaor0\nZg2SZwsaQ3+UNo5Z76xQJBHRYLMV4lwvbtTUKsqVbHP73GLjDGEE1wfrFnDeFXoh\nPbeuxTfoi7ruWkEoMWjsTV3RFxa/gbSrZQ7N/HkCgYEAz6HkIubwJabzM3z1r3nR\nH6bP67yOcl3OCP6Nfr84fvWzvTWr2u6xVYN9++LgjHkveI6hILzdSidGnmh74dSk\nD/jBcm4CxXWwlvvkD+OqBM2u9Jer/K6QHRXzZKhj1L61M6CyxHfXX/4dbE0pJY5G\nrKR78lMB8q2Oxb//dwu7AykCgYEAzSZRxFyMq5kAEL+MhXkrEplZuvNSORQ9C9er\nRlogaF5Vp4+Ea2TG1jn6CyNxVVVNVKLVanNds/BBJOETrXbCBFrMEtrQxCfPrS8v\n4bptWlfLaoNRNu9YhJE4qsExmgBlWrh1PcNGCPJlRy1wz4Fe2b7cUh782APppMQ3\n49KI4rUCgYEAkoF1+1aejsLNikAbD7VR5RaMUZdbn8Em11veNVfyIkt2hwSu/a08\n/czpgWll7li4MUXa1cHOFzu9bZrmBsRG+2oX/Yk4dWIEt5SHKNsIpZkIYVgAKCx4\nTb2mXxkeUAg8zXAPk+fH1dj1o+ySIwjQP5NUTflaP4VNX6WJOdPSInkCgYEAiY6w\nNSJ5kHY+/PvzlWvx3b7F0/1jnLJdXJt4VOwJ3vGiLYCmIfyo9uxZJS7Wx4kzGRU2\nVPKWWhk3FSt2rlF7NsBLJjli0qR/NHj3ejwvJuzHkNwMkPFcQUe+34A7ai/pxjL5\nKjjNtSITlu55PipZF1hLEyWEFLRK7hhEAZciAiECgYBkCd4GTpxP+yMAaYy5sq3z\nAiLyud69XNq4Ch/JtYQtZ/Q6sYAl/7u/TY+iWK2nmEH6QuhtmK2cj9FwrAIfi1n4\nwCiM04PvYk+/PLcCFIdH5BYKAndh912lqEyCK+WTW5zLxdh3VunXxPzgxvgmPDwB\nH73nik7Nex7SaAPMNW1aBw==\n-----END PRIVATE KEY-----\n",
      "client_email": "sportme@sportme-e47cd.iam.gserviceaccount.com",
      "client_id": "105328991024977333295",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/sportme%40sportme-e47cd.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    final credentials = await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );

    client.close();
    return credentials.accessToken.data;
  }

  /// Send FCM to individual device
  Future<void> sendNotification(
    String deviceToken,
    String title,
    String body,
  ) async {
    String serverKey = await getAccessToken();

    const url =
        'https://fcm.googleapis.com/v1/projects/sportme-e47cd/messages:send';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    };

    final data = {
      "message": {
        "token": deviceToken,
        "notification": {
          "title": title,
          "body": body,
        },
      },
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        log('Notification sent successfully!');
      } else {
        log('Failed to send notification: ${response.statusCode}');
        log('Response body: ${response.body}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// Send FCM to topic
  Future<void> sendNotificationToTopic({
    required String notificationTopic,
    String? title,
    String? body,
  }) async {
    String serverKey = await getAccessToken();
    const url =
        'https://fcm.googleapis.com/v1/projects/sportme-e47cd/messages:send';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    };

    final data = {
      "message": {
        "topic": notificationTopic,
        "notification": {
          "title": title ?? "Notification",
          "body": body ?? "",
        },
        "data": {
          "key1": "value1",
          "key2": "value2",
        },
      },
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        log('Notification sent to topic successfully!');
      } else {
        log('Failed to send topic notification: ${response.statusCode}');
        log('Response body: ${response.body}');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
