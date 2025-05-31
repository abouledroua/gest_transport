import 'package:flutter/material.dart';

class AppSizes {
  static double maxWidth = 800;
  static late double widthScreen, heightScreen, fullHeight, fullWidth;
  static const appPadding = 16.0;
  static bool showSidebar = false;

  static void setSizeScreen(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;
    widthScreen = MediaQuery.of(context).size.width;
    // widthScreen = min(MediaQuery.of(context).size.width, maxWidth);
    heightScreen = MediaQuery.of(context).size.height;
    debugPrint('widthScreen=$widthScreen');
    fullHeight = MediaQuery.of(context).size.height;
    fullWidth = MediaQuery.of(context).size.width;
  }
}
