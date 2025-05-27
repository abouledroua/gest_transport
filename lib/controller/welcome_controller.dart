import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/constant/sizes.dart';

class WelcomeController extends GetxController {
  @override
  void onReady() {
    Timer(const Duration(seconds: 3), close);
    super.onReady();
  }

  close() {
    Get.offAllNamed(AppRoute.login);
  }

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    super.onInit();
  }
}
