import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/controller/profile/profile_controller.dart';
import 'package:prime_social_media_flutter_ui_kit/services/db_service.dart';
import 'package:prime_social_media_flutter_ui_kit/services/notification_service.dart';
import 'package:prime_social_media_flutter_ui_kit/translation/app_translation.dart';
import 'package:prime_social_media_flutter_ui_kit/views/splash/splash_view.dart';

import 'controller/db_controller.dart';
import 'controller/translation_controller.dart';
import 'routes/app_routes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initTranslation();

  // Check if Firebase is already initialized
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    // Ignore duplicate initialization error
    if (e
        .toString()
        .contains("A Firebase App named \"[DEFAULT]\" already exists")) {
      // Already initialized, do nothing
    } else {
      rethrow; // Re-throw unexpected errors
    }
  }

  NotificationService().initialize();
  await NotificationService().initializeLocalNotifications();

  Get.put(
    DbService.init(GetStorage()),
    permanent: true,
  );
  Get.put(DbController(), permanent: true);

  runApp(const MyApp());
}

Future<void> initTranslation() async {
  await Get.putAsync(() async => AppTranslations());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TranslationController translationController =
        Get.put(TranslationController());
    Get.put(ProfileController());
    return GetMaterialApp(
      title: AppString.appDisplayName,
      translations: AppTranslations(),
      locale: Locale(translationController.locale),
      fallbackLocale: const Locale(AppString.enText),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
        useMaterial3: true,
        splashColor: AppColor.transparentColor,
        highlightColor: AppColor.transparentColor,
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: AppSize.appSize0,
          backgroundColor: AppColor.backgroundColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashView(),
      defaultTransition: Transition.fade,
      getPages: AppRoutes.pages,
      builder: (context, child) {
        return Container(
          color: AppColor.backgroundColor,
          child: Center(
            child: Container(
              color: AppColor.backgroundColor,
              width: kIsWeb ? AppSize.appSize800 : null,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
