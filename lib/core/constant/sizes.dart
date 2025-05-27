import 'package:flutter/material.dart';

class AppSizes {
  static double maxWidth = 800;
  static late double widthScreen, heightScreen, fullHeight, fullWidth;
  static const appPadding = 16.0;

  static setSizeScreen(context) {
    maxWidth = MediaQuery.of(context).size.width;
    widthScreen = MediaQuery.of(context).size.width;
    // widthScreen = min(MediaQuery.of(context).size.width, maxWidth);
    heightScreen = MediaQuery.of(context).size.height;
    debugPrint('widthScreen=$widthScreen');
    fullHeight = MediaQuery.of(context).size.height;
    fullWidth = MediaQuery.of(context).size.width;
  }
}


// import 'dart:math';

// import 'package:flutter/material.dart';

// const double maxWidth = 800;
// late double widthScreen, heightScreen, fullHeight, fullWidth;


// setSizeScreen(context) {
//   widthScreen = min(MediaQuery.of(context).size.width, maxWidth);
//   heightScreen = MediaQuery.of(context).size.height;

//   fullHeight = MediaQuery.of(context).size.height;
//   fullWidth = MediaQuery.of(context).size.width;
// }
