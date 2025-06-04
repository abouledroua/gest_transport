import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/listtransport_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/sizes.dart';

class FilterDrawerWidget extends StatelessWidget {
  final ListTransportsController controller;
  final BuildContext parentContext;
  const FilterDrawerWidget({super.key, required this.controller, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          color: AppColor.grey.withValues(alpha: 0.2),
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Text("Filtrer".tr, style: Theme.of(context).textTheme.titleLarge)),
                    IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.of(parentContext).maybePop()),
                  ],
                ),
                const Divider(),
                const SizedBox(height: AppSizes.appPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Exercice'.tr, style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(
                      width: 80,
                      child: Visibility(
                        visible: controller.loadingExercice.value,
                        replacement: myDropDown(
                          label: 'Exercice'.tr,
                          value: controller.dropExercice,
                          items: controller.myDropExerciceList,
                          onChanged: (value) {
                            controller.updateDropExerciceValue(value);
                          },
                          hint: "Choisir l'Exercice".tr,
                        ),
                        child: const Center(child: CircularProgressIndicator.adaptive()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.appPadding),
                Row(
                  children: [
                    Text('Client'.tr, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: myTextField(
                        controller: controller.clientController,
                        context: context,
                        onChanged: (newValue) {
                          controller.updateClientQuery(newValue);
                        },
                        onClear: () {
                          controller.clientController.text = "";
                          controller.updateClientQuery("");
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.appPadding),
                Row(
                  children: [
                    Text('Transporteur'.tr, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: myTextField(
                        controller: controller.transpExterneController,
                        context: context,
                        onChanged: (newValue) {
                          controller.updateTransporteurExterneQuery(newValue);
                        },
                        onClear: () {
                          controller.transpExterneController.text = "";
                          controller.updateTransporteurExterneQuery("");
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.appPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date'.tr, style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(
                      width: 140,
                      child: myTextField(
                        controller: controller.dateController,
                        context: context,
                        onTap: () async {
                          DateTime? selectDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (selectDate != null) {
                            String myDate = "${selectDate.year}-${selectDate.month}-${selectDate.day}";
                            controller.updateDate(myDate);
                          }
                          controller.tableFocusNode.requestFocus();
                        },
                        onClear: () {
                          controller.dateController.text = "";
                          controller.updateDate("");
                        },
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.appPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date Au'.tr, style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(
                      width: 140,
                      child: myTextField(
                        controller: controller.dateAuController,
                        context: context,
                        onTap: () async {
                          DateTime? selectDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (selectDate != null) {
                            String myDate = "${selectDate.year}-${selectDate.month}-${selectDate.day}";
                            controller.updateDateAu(myDate);
                          }
                        },
                        onClear: () {
                          controller.dateAuController.text = "";
                          controller.updateDateAu("");
                        },
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.appPadding),
                Row(
                  children: [
                    Text('Destination'.tr, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: Visibility(
                        visible: controller.loadingDestination.value,
                        replacement: myDropDown(
                          label: 'Destination'.tr,
                          value: controller.dropDestination,
                          items: controller.myDropDestinationList,
                          onChanged: (value) {
                            controller.updateDropDestinationValue(value);
                          },
                          hint: "Choisir la Destination".tr,
                        ),
                        child: const Center(child: CircularProgressIndicator.adaptive()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.appPadding),
                Row(
                  children: [
                    Text('Depot'.tr, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: Visibility(
                        visible: controller.loadingDepot.value,
                        replacement: myDropDown(
                          label: 'Depot'.tr,
                          value: controller.dropDepot,
                          items: controller.myDropDepotList,
                          onChanged: (value) {
                            controller.updateDropDepotValue(value);
                          },
                          hint: "Choisir_Depot".tr,
                        ),
                        child: const Center(child: CircularProgressIndicator.adaptive()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.appPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Etat'.tr, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(width: 20),
                    Expanded(
                      child: myDropDown(
                        label: 'Etat'.tr,
                        value: controller.dropEtat,
                        items: controller.myDropEtatList,
                        onChanged: (value) {
                          controller.updateDropEtatValue(value);
                        },
                        hint: "Choisir l'Etat".tr,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField myTextField({
    required TextEditingController controller,
    required BuildContext context,
    Function()? onClear,
    Function()? onTap,
    Function(String)? onChanged,
    bool readOnly = false,
    String? label,
  }) => TextField(
    controller: controller,
    onTap: onTap,
    enableInteractiveSelection: !readOnly,
    readOnly: readOnly,
    onChanged: onChanged,
    decoration: InputDecoration(
      hintText: label ?? "",
      helperStyle: Theme.of(context).textTheme.titleMedium,
      fillColor: AppColor.secondaryColor,
      filled: true,
      suffixIcon: InkWell(
        onTap: onClear,
        child: Ink(child: const Icon(Icons.clear, color: AppColor.grey)),
      ),
      border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
    ),
  );

  SizedBox myDropDown({
    required String label,
    required String? value,
    required List<DropdownMenuItem<dynamic>>? items,
    required Function(dynamic) onChanged,
    Function()? onClear,
    required String hint,
  }) => SizedBox(
    height: 50,
    child: DropdownButtonHideUnderline(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.grey),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Expanded(
              child: DropdownButton(
                items: items,
                isExpanded: true,
                borderRadius: BorderRadius.circular(5),
                hint: Text(hint),
                value: value,
                style: Theme.of(Get.context!).textTheme.titleSmall!.copyWith(color: AppColor.black),
                iconSize: 0,
                iconEnabledColor: AppColor.grey,
                onChanged: onChanged,
              ),
            ),
            if (onClear != null)
              InkWell(
                onTap: onClear,
                child: Ink(child: const Icon(Icons.clear, color: AppColor.grey)),
              ),
          ],
        ),
      ),
    ),
  );
}
