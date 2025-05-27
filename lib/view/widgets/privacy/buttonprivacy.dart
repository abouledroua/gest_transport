import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/privacy_controller.dart';
import '../../../core/constant/color.dart';

class ButtonPrivacy extends StatelessWidget {
  const ButtonPrivacy({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<PrivacyController>(
      builder: (controller) => InkWell(
          onTap: controller.accept
              ? () async {
                  controller.continuer();
                }
              : null,
          child: Ink(
              child: Row(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
            Container(
                padding: const EdgeInsets.all(10),
                color: controller.accept ? AppColor.green : AppColor.greyShade,
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Text("Continuer", style: TextStyle(color: AppColor.white, fontSize: 20)),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward, color: AppColor.white)
                ]))
          ]))));
}
