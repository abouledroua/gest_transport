import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/settingservice.dart';

class LocaleController extends GetxController {
  Locale? language;
  SettingServices sc = Get.find();

  @override
  void onInit() {
    super.onInit();
    String lang = sc.sharedPrefs.getString("lang") ?? "";
    if (lang == "ar") {
      language = const Locale("ar");
    } else if (lang == "en") {
      language = const Locale("en");
    } else if (lang == "fr") {
      language = const Locale("fr");
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
    }
  }

  changeLang(String langCode) {
    Locale locale = Locale(langCode);
    sc.sharedPrefs.setString("lang", langCode);
    Get.updateLocale(locale);
  }
}
