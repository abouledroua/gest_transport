import 'package:flutter/material.dart';

import '../../core/constant/sizes.dart';
import '../widgets/my_menu_bar.dart';
import 'mywidget.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key, required this.child, this.endDrawer});
  final Widget child;
  final Widget? endDrawer;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      AppSizes.setSizeScreen(context);
      return MyWidget(
        endDrawer: endDrawer,
        drawer: AppSizes.showSidebar ? null : Drawer(child: MyMenuBar()),
        child: child,
      );
    },
  );
}
