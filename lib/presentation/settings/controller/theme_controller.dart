import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  var theme = ThemeMode.light.obs;

  void switchTheme() {
    theme.value = theme.value == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    Get.changeThemeMode(theme.value);
  }
}
