import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';

class HomeController extends GetxController {
  bool _versionDemo = true;
  int _index = 0;

  get isVersionDemo => _versionDemo;
  get currentIndex => _index;

  setVersionDemo(bool value) {
    _versionDemo = value;
    update();
  }

  setIndex({required int newIndex, firstGo = false}) {
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
