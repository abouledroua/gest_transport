import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controller/myuser_controller.dart';
import '../../../core/class/responsive.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/sizes.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) => Row(children: [
        Padding(
            padding: const EdgeInsets.all(AppSizes.appPadding),
            child: Stack(children: [
              SvgPicture.asset("assets/icons/Bell.svg", semanticsLabel: 'Dart Logo'),
              Positioned(
                  right: 0,
                  child: Container(
                      height: 10, width: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.red)))
            ])),
        Container(
            margin: const EdgeInsets.only(left: AppSizes.appPadding),
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.appPadding, vertical: AppSizes.appPadding / 2),
            child: Row(children: [
              const Icon(Icons.person),
              if (!Responsive.isMobile(context))
                GetBuilder<MyUserController>(
                  builder: (userController) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSizes.appPadding / 2),
                      child: Text('Hi, ${userController.username}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: AppColor.textColor, fontWeight: FontWeight.w800))),
                )
            ]))
      ]);
}
