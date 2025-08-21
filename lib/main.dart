import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_color.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_size.dart';
import 'package:prime_social_media_flutter_ui_kit/config/app_string.dart';
import 'package:prime_social_media_flutter_ui_kit/firebase_options.dart';
import 'package:prime_social_media_flutter_ui_kit/services/db_service.dart';
import 'package:prime_social_media_flutter_ui_kit/translation/app_translation.dart';
import 'package:prime_social_media_flutter_ui_kit/views/splash/splash_view.dart';

import 'controller/auth_controller.dart';
import 'controller/db_controller.dart';
import 'controller/translation_controller.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initTranslation();

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

  // Initialize Stripe
  Stripe.publishableKey =
      "pk_test_51Joui7L1cSJT1UwBLOUBZqLx59AjgpFRE7hB6zF3hP74Kow1Q8UZt2sCSRxB6Y4DhX0lTxng5k22L17CHZeEYmpR00p30nE3kY";
  await Stripe.instance.applySettings();

  Get.put(
    DbService.init(GetStorage()),
    permanent: true,
  );
  Get.put(DbController(), permanent: true);
  Get.put(AuthController(), permanent: true);
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
