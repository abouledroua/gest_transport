import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/listtransport_controller.dart';
import '../../core/constant/color.dart';
import '../../core/constant/sizes.dart';
import '../../core/mydivider.dart';
import '../widgets/list_transport/emptylisttransport.dart';
import '../widgets/list_transport/list_transport_table_widget.dart';
import '../widgets/loadingbarwidget.dart';
import 'myscreen.dart';

class ListTransportPage extends StatelessWidget {
  const ListTransportPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<ListTransportsController>()) {
      Get.delete<ListTransportsController>();
    }
    Get.put(ListTransportsController());
    return MyScreen(
      title: "Transport".tr,
      child: GetBuilder<ListTransportsController>(
        builder: (controller) => Expanded(
          child: Column(
            children: [
              const SizedBox(height: AppSizes.appPadding),
              actionButton(context, controller),
              if (!controller.loading && !controller.loadingFilter && controller.filter)
                filterWidget(context, controller),
              if (controller.loading) const LoadingBarWidget(),
              if (!controller.loading && controller.transports.isEmpty) const EmptyListTransports(),
              if (!controller.loading && controller.transports.isNotEmpty) const ListTransportWidgetTable(),
            ],
          ),
        ),
      ),
    );
  }

  actionButton(BuildContext context, controller) => Row(
    children: [
      Expanded(
        child: Text('List_Transports'.tr, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
      ),
      if (controller.selectIndex > -1 && !controller.loading)
        IconButton(
          tooltip: "Imprimer".tr,
          onPressed: () {
            controller.getList(showMessage: true);
          },
          icon: const Icon(Icons.print_outlined, color: AppColor.purple),
        ),
      if (controller.selectIndex > -1 && !controller.loading) const MyDivider(),
      if (controller.selectIndex > -1 && !controller.loading)
        IconButton(
          tooltip: "Supprimer".tr,
          onPressed: () {
            controller.getList(showMessage: true);
          },
          icon: Icon(Icons.delete_forever, color: AppColor.red),
        ),
      if (controller.selectIndex > -1 && !controller.loading)
        IconButton(
          tooltip: "Modifier".tr,
          onPressed: () {
            controller.getList(showMessage: true);
          },
          icon: const Icon(Icons.edit_document, color: AppColor.blue2),
        ),
      if (!controller.loading)
        IconButton(
          tooltip: "Ajouter".tr,
          onPressed: () {
            controller.getList(showMessage: true);
          },
          icon: const Icon(Icons.add_circle_outline_sharp, color: AppColor.green2),
        ),
      if (!controller.loading) const MyDivider(),
      if (!controller.loading)
        IconButton(
          tooltip: "Imprimer la Liste".tr,
          onPressed: () {
            controller.getList(showMessage: true);
          },
          icon: const Icon(Icons.list_alt_outlined, color: AppColor.black),
        ),
      if (!controller.loading)
        IconButton(
          tooltip: "Actualiser".tr,
          onPressed: () {
            controller.getList(showMessage: true);
          },
          icon: const Icon(Icons.refresh),
        ),
      if (!controller.loading)
        IconButton(
          tooltip: controller.filter ? "Annuler Filtre".tr : "Filtrer".tr,
          onPressed: () {
            controller.updatefiltrer();
          },
          icon: Icon(
            controller.filter ? Icons.filter_alt_off_rounded : Icons.filter_alt_rounded,
            color: controller.filter ? AppColor.grey : AppColor.amber,
          ),
        ),
    ],
  );

  filterWidget(BuildContext context, ListTransportsController controller) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      const SizedBox(width: AppSizes.appPadding),
      SizedBox(
        width: 80,
        child: Visibility(
          visible: controller.loadingExercice,
          replacement: myDropDown(
            label: 'Exercice'.tr,
            value: controller.dropExercice,
            items: controller.myDropExerciceList,
            onChanged: (value) {
              controller.updateDropExerciceValue(value);
            },
            onClear: () {
              controller.updateDropExerciceValue(null);
            },
            hint: "Choisir l'Exercice".tr,
          ),
          child: const Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
      const SizedBox(width: AppSizes.appPadding),
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
          label: "Client".tr,
        ),
      ),
      const SizedBox(width: AppSizes.appPadding),
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
          label: "Transporteur Externe".tr,
        ),
      ),
      const SizedBox(width: AppSizes.appPadding),
      SizedBox(
        width: 100,
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
          },
          label: "Date",
          readOnly: true,
        ),
      ),
      const SizedBox(width: AppSizes.appPadding),
      Expanded(
        flex: 2,
        child: Visibility(
          visible: controller.loadingExercice,
          replacement: myDropDown(
            label: 'Destination'.tr,
            value: controller.dropDestination,
            items: controller.myDropDestinationList,
            onChanged: (value) {
              controller.updateDropDestinationValue(value);
            },
            onClear: () {
              controller.updateDropDestinationValue(null);
            },
            hint: "Choisir la Déstination".tr,
          ),
          child: const Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
      const SizedBox(width: AppSizes.appPadding),
      SizedBox(
        width: 130,
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
  );

  myTextField({
    required TextEditingController controller,
    required BuildContext context,
    Function()? onClear,
    Function()? onTap,
    Function(String)? onChanged,
    bool readOnly = false,
    required String label,
  }) => TextField(
    controller: controller,
    onTap: onTap,
    enableInteractiveSelection: !readOnly,
    readOnly: readOnly,
    onChanged: onChanged,
    decoration: InputDecoration(
      hintText: label,
      helperStyle: Theme.of(context).textTheme.titleMedium,
      fillColor: AppColor.secondaryColor,
      filled: true,
      border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
    ),
  );

  myDropDown({
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
