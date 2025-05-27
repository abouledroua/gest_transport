import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/privacy_controller.dart';

class SwitchPrivacy extends StatelessWidget {
  const SwitchPrivacy({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<PrivacyController>(
      builder: (controller) => InkWell(
          onTap: () {
            controller.updateAccepte();
          },
          child: Ink(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Switch(
                value: controller.accept,
                onChanged: (value) {
                  controller.updateAccepte();
                }),
            const Padding(
                padding: EdgeInsets.all(8.0),
                child: Wrap(children: [
                  Text("J'accepte les terme d'utilisation",
                      overflow: TextOverflow.clip)
                ]))
          ]))));
}
