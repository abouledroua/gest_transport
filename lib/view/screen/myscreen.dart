import 'package:flutter/material.dart';

import '../../core/constant/sizes.dart';
import '../widgets/my_menu_bar.dart';
import 'mywidget.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key, required this.child, required this.title});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      bool showSidebar = constraints.maxWidth > 1050; // Adjust threshold as needed
      AppSizes.setSizeScreen(context);

      return MyWidget(
        // leading: showSidebar
        //     ? null // No leading icon if sidebar is shown
        //     : Builder(
        //         builder: (context) => IconButton(
        //           icon: const Icon(Icons.menu),
        //           onPressed: () {
        //             Scaffold.of(context).openDrawer();
        //           },
        //         ),
        //       ),
        drawer: showSidebar
            ? null // No drawer if sidebar is shown
            : Drawer(child: MyMenuBar()),
        // title: title,
        child: Row(children: [if (showSidebar) MyMenuBar(), child]),
      );
    },
  );
}
