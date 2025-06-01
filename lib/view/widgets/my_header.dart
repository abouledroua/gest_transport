import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/color.dart';
import '../../core/constant/sizes.dart';

class MyHeaderWidget extends StatelessWidget {
  final String title;
  final List<Widget>? action;
  const MyHeaderWidget({super.key, required this.title, this.action});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => Row(
      children: [
        if (Navigator.canPop(Get.context!))
          IconButton(
            color: AppColor.black,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        if (!AppSizes.showSidebar)
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.filter_list, color: AppColor.black),
              tooltip: "Menu".tr,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),

        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
        ),
        
        ...action ?? [],
      ],
    ),
  );
}
