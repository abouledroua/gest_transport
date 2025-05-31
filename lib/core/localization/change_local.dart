import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../services/settingservice.dart';

class LocaleController extends GetxController {
  Locale? language;
  SettingServices sc = Get.find();

  @override
  void onInit() async {
    super.onInit();
    String lang = sc.sharedPrefs.getString("lang") ?? "";
    if (lang.isEmpty) {
      lang = Get.deviceLocale?.languageCode ?? "en";
    }
    language = Locale(lang);
    await initializeDateFormatting(lang, null);
  }

  Future<void> changeLang(String langCode) async {
    Locale locale = Locale(langCode);
    sc.sharedPrefs.setString("lang", langCode);
    await initializeDateFormatting(langCode, null);
    Get.updateLocale(locale);
  }
}
