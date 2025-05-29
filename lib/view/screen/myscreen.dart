import 'package:flutter/material.dart';

import '../../core/constant/sizes.dart';
import '../widgets/my_menu_bar.dart';
import 'mywidget.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key, required this.child, required this.title, this.endDrawer});
  final String title;
  final Widget child;
  final Widget? endDrawer;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      AppSizes.setSizeScreen(context);
      return MyWidget(
        endDrawer: endDrawer,
        drawer: AppSizes.showSidebar ? null : Drawer(child: MyMenuBar()),
        child: Row(
          children: [
            // if (AppSizes.showSidebar) MyMenuBar(),
            child,
          ],
        ),
      );
    },
  );
}
