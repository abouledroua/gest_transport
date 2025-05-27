import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/privacy_controller.dart';
import '../../core/constant/color.dart';
import '../../core/constant/data.dart';
import '../widgets/privacy/buttonprivacy.dart';
import '../widgets/privacy/privacytext.dart';
import '../widgets/privacy/swicthprivacy.dart';
import 'mywidget.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<PrivacyController>()) {
      Get.delete<PrivacyController>();
    }
    PrivacyController controller = Get.put(PrivacyController());
    double heightPad = 20;
    return MyWidget(
        showDemo: false,
        backgroundColor: AppColor.white,
        child: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              controller.onWillPop();
            },
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(children: [
                  SizedBox(height: heightPad),
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Règles d'utilisation de l'application",
                              style: Theme.of(context).textTheme.displayLarge))),
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Veuillez lire et accepter les termes d'utilisation de l'application ${AppData.privacyAppName}",
                              style: Theme.of(context).textTheme.bodyLarge))),
                  const Divider(color: AppColor.black),
                  const PrivacyText(),
                  const Divider(),
                  const SwitchPrivacy(),
                  SizedBox(height: heightPad),
                  const ButtonPrivacy(),
                  SizedBox(height: heightPad)
                ]))));
  }
}
