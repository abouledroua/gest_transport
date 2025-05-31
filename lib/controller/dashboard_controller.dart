import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  bool _versionDemo = true;
  int _index = 1;

  bool get  isVersionDemo => _versionDemo;
  int get currentIndex => _index;

  void setVersionDemo(bool value) {
    _versionDemo = value;
    update();
  }

  void setIndex(int newIndex) {
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
