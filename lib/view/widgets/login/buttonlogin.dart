import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/login_controller.dart';
import '../../../core/constant/color.dart';

class ButtonLogin extends StatelessWidget {
  final Color backcolor, textcolor;
  final void Function()? onPressed;
  const ButtonLogin({super.key, this.onPressed, required this.textcolor, required this.backcolor});

  @override
  Widget build(BuildContext context) => GetBuilder<LoginController>(
      builder: (controller) => Visibility(
          visible: controller.valider,
          replacement: ElevatedButton(
              style: ElevatedButton.styleFrom(foregroundColor: AppColor.white, backgroundColor: AppColor.red),
              onPressed: onPressed,
              child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text("connect_login".tr,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(color: textcolor)))),
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: AppColor.red,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(color: AppColor.white),
                    const SizedBox(width: 24),
                    FittedBox(
                        child: Text("connect_encours".tr,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: textcolor)))
                  ]))));
}
