import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/listtransport_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/sizes.dart';

class EmptyListTransports extends StatelessWidget {
  const EmptyListTransports({super.key});

  @override
  Widget build(BuildContext context) {
    ListTransportsController controller = Get.find();
    return SizedBox(
      height: AppSizes.fullHeight / 2,
      child: Center(
        child: Container(
          color: AppColor.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Liste_vide".tr,
                  style: TextStyle(fontSize: 22, color: AppColor.green, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(foregroundColor: AppColor.white, backgroundColor: AppColor.produit),
                onPressed: () {
                  controller.getList(showMessage: true);
                },
                icon: const Icon(Icons.refresh, color: AppColor.white),
                label: Text("Actualiser".tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
