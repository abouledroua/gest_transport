import 'package:flutter/material.dart';

import '../../../core/class/responsive.dart';
import '../../../core/constant/color.dart';
import 'profile_info.dart';
import 'search_field.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      if (!Responsive.isDesktop(context))
        IconButton(
          onPressed: () {
            final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
            if (!scaffoldKey.currentState!.isDrawerOpen) {
              scaffoldKey.currentState!.openDrawer();
            }
          },
          icon: Icon(Icons.menu, color: AppColor.textColor.withValues(alpha: 0.5)),
        ),
      const Expanded(child: SearchField()),
      const Spacer(),
      const ProfileInfo(),
    ],
  );
}
