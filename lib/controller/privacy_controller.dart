import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/sizes.dart';
import '../core/services/settingservice.dart';
import 'myuser_controller.dart';

class PrivacyController extends GetxController {
  bool accept = false;

  void updateAccepte() {
    accept = !accept;
    update();
  }

  Future<bool> onWillPop() async => false;

  void continuer() {
    SettingServices c = Get.find();
    MyUserController userController = Get.find();
    c.sharedPrefs.setInt("Privacy_${userController.idUser}", 1);
    Get.back();
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context!);
    super.onInit();
  }
}
