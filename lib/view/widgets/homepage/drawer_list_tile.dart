import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/data.dart';
import '../../../core/localization/change_local.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({super.key, required this.title, required this.icon, required this.myIndex, this.color});

  final int myIndex;
  final IconData? icon;
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
    builder: (controller) => ListTile(
      onTap: () {
        debugPrint("Tapped on index: $myIndex");
        if (myIndex == 9) {
          AppData.logout();
        } else if (myIndex == 8) {
          LocaleController contr = Get.find<LocaleController>();
          if (contr.language == const Locale('fr')) {
            contr.changeLang('en');
          } else if (contr.language == const Locale('en')) {
            contr.changeLang('ar');
          } else if (contr.language == const Locale('ar')) {
            contr.changeLang('fr');
          }
        } else {
          controller.setIndex(newIndex: myIndex);
        }
      },
      tileColor: controller.currentIndex == myIndex ? AppColor.blue1 : Colors.transparent,
      leading: Icon(
        icon,
        size: controller.currentIndex == myIndex ? 24 : 20,
        color: color ?? (controller.currentIndex == myIndex ? AppColor.white : AppColor.grey),
      ),
      title: Text(
        title,
        style: controller.currentIndex == myIndex
            ? Theme.of(context).textTheme.titleMedium!.copyWith(color: color ?? AppColor.white)
            : Theme.of(context).textTheme.titleSmall!.copyWith(color: color ?? AppColor.grey),
      ),
    ),
  );
}
