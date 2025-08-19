import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/model/sport_model.dart';
import 'package:prime_social_media_flutter_ui_kit/services/sports_services.dart';
import 'package:prime_social_media_flutter_ui_kit/utils/widget_helper.dart';

class SportSelectionController extends GetxController {
  var sports = <SportModel>[].obs;
  var selectedSportId = RxnInt(); // only one sport at a time
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchSports();
    super.onInit();
  }

  Future<void> fetchSports() async {
    try {
      isLoading.value = true;
      var apiRes = await SportsServices().fetchSports();
      sports.value = apiRes.data;
      WidgetHelper.showSnackBar(title: "Sports Loaded");
    } catch (e) {
      log(e.toString());
      WidgetHelper.showSnackBar(title: "Error loading sports");
    } finally {
      isLoading.value = false;
    }
  }

  void selectSport(int sportId) {
    // If clicked same sport again, deselect it, else select new one
    if (selectedSportId.value == sportId) {
      selectedSportId.value = null;
    } else {
      selectedSportId.value = sportId;
    }
  }

  Future<void> submitSelectedSports() async {
    if (selectedSportId.value == null) {
      WidgetHelper.showSnackBar(title: "Please select a sport first");
      return;
    }

    try {
      isLoading.value = true;
      final result =
          await SportsServices().selectSports(selectedSportId.value!);

      if (result) {
        WidgetHelper.showSnackBar(
            title: "Sport Selected Successfully", bgColor: Colors.white);
      }
    } catch (e) {
      WidgetHelper.showSnackBar(
          title: "Sport selection faild $e", bgColor: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
