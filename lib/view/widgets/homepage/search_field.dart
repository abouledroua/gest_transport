import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/mysearch_controller.dart';
import '../../../core/constant/color.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<MySearchController>()) {
      Get.delete<MySearchController>();
    }
    MySearchController controller = Get.put(MySearchController());
    return TextField(
        controller: controller.queryController,
        decoration: InputDecoration(
            hintText: "Recherche",
            helperStyle: TextStyle(color: AppColor.textColor.withOpacity(0.5), fontSize: 15),
            fillColor: AppColor.secondaryColor,
            filled: true,
            border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
            prefixIcon: Icon(Icons.search, color: AppColor.textColor.withOpacity(0.5))));
  }
}
