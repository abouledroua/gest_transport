import 'package:flutter/material.dart';

import '../../core/class/responsive.dart';
import '../../core/constant/color.dart';
import '../widgets/dashBoard/dashboard_content.dart';
import '../widgets/homepage/drawer_menu.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: AppColor.bgColor,
      drawer: const DrawerMenu(),
      body: SafeArea(
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (Responsive.isDesktop(context)) const Expanded(child: DrawerMenu()),
        const Expanded(flex: 5, child: DashboardContent())
      ])));
}
