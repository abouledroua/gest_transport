import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  bool _versionDemo = true;
  int _index = 1;

  get isVersionDemo => _versionDemo;
  get currentIndex => _index;

  setVersionDemo(bool value) {
    _versionDemo = value;
    update();
  }

  setIndex(int newIndex) {
    _index = newIndex;
    update();
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _versionDemo = true;
    super.onInit();
  }
}
