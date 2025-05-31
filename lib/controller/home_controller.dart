import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';

class HomeController extends GetxController {
  bool _versionDemo = true;
  int _index = 0;

  bool get isVersionDemo => _versionDemo;
  int get currentIndex => _index;

  void setVersionDemo(bool value) {
    _versionDemo = value;
    update();
  }

  void setIndex({required int newIndex, firstGo = false}) {
    _index = newIndex;
    update();
    AppRoute.goToPage(index: _index, firstGo: firstGo);
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _versionDemo = true;
    super.onInit();
  }
}
