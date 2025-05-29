import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/details_transport_controller.dart';
import '../../../core/class/transport.dart';
import '../../../core/constant/data.dart';
import '../loadingbarwidget.dart';

class DetailsTableWidget extends StatelessWidget {
  final Transport item;
  const DetailsTableWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<DetailsTransportsController>()) {
      Get.delete<DetailsTransportsController>();
    }
    Get.put(DetailsTransportsController(item));
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Center(
          child: Text(
            'Détails du transport'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        Divider(),
        DataTable(
          columns: [
            DataColumn(
              label: Row(
                children: [
                  Text(
                    '${'N°'.tr}:',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' ${item.exercice}/${item.idTransport}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            DataColumn(
              label: Row(
                children: [
                  Text(
                    '${'Date'.tr}:',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(' ${item.date}', textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
            ),
            DataColumn(
              label: Row(
                children: [
                  Text(
                    '${'Client'.tr}:',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' ${item.nomClient}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          ],
          rows: [],
        ),
        Divider(),
        Obx(() {
          final controller = Get.find<DetailsTransportsController>();
          if (controller.loading.value) {
            return LoadingBarWidget();
          }
          if (controller.error.value) {
            return Center(
              child: Text('Liste_vide'.tr, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.red)),
            );
          }
          if (controller.details.isEmpty) {
            return Center(
              child: Text('Liste_vide'.tr, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.red)),
            );
          }
          return myTable(context);
        }),
      ],
    );
  }

  SizedBox myTable(BuildContext context) {
    final controller = Get.find<DetailsTransportsController>();
    return SizedBox(
      height: 130,
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowHeight: 70,
            columnSpacing: 0,
            columns: [
              DataColumn(label: _borderedHeaderCell(context, 'N°'.tr, 30)),
              DataColumn(label: _borderedHeaderCell(context, 'Type'.tr, 55)),
              DataColumn(label: _borderedHeaderCell(context, 'Fournisseur'.tr, 100)),
              DataColumn(label: _borderedHeaderCell(context, 'Produit'.tr, 70)),
              DataColumn(label: _borderedHeaderCell(context, 'Quantité'.tr, 70)),
              DataColumn(label: _borderedHeaderCell(context, 'Montant Produit'.tr, 90)),
              DataColumn(label: _borderedHeaderCell(context, 'Transport Interne'.tr, 70)),
              DataColumn(label: _borderedHeaderCell(context, 'Montant Transport Interne'.tr, 90)),
              DataColumn(label: _borderedHeaderCell(context, 'Montant Transport Externe'.tr, 90)),
              DataColumn(label: _borderedHeaderCell(context, 'Total'.tr, 90)),
              DataColumn(label: _borderedHeaderCell(context, 'Etat'.tr, 90)),
            ],
            rows: controller.details
                .map(
                  (detail) => DataRow(
                    cells: [
                      DataCell(_borderedCell(context, detail.num.toString(), 30)),
                      DataCell(_borderedCell(context, detail.type == 1 ? "Produit".tr : "Argent".tr, 55)),
                      DataCell(_borderedCell(context, detail.nomFournisseur, 100)),
                      DataCell(_borderedCell(context, detail.designationProduit, 70)),
                      DataCell(_borderedCell(context, detail.qte == 0 ? '' : AppData.formatMoney(detail.qte), 70)),
                      DataCell(_borderedCell(context, AppData.formatMoney(detail.montantProduit), 90)),
                      DataCell(_borderedCell(context, detail.transportInterne ? "oui".tr : "non".tr, 70)),
                      DataCell(
                        _borderedCell(
                          context,
                          detail.montantTransInterne == 0 ? '' : AppData.formatMoney(detail.montantTransInterne),
                          90,
                        ),
                      ),
                      DataCell(
                        _borderedCell(
                          context,
                          detail.montantTransExterne == 0 ? '' : AppData.formatMoney(detail.montantTransExterne),
                          90,
                        ),
                      ),
                      DataCell(_borderedCell(context, detail.total == 0 ? '' : AppData.formatMoney(detail.total), 90)),
                      DataCell(
                        _borderedCell(
                          context,
                          detail.etat == 1
                              ? "Non Livré".tr
                              : detail.etat == 2
                              ? "Livré".tr
                              : "Retourné".tr,
                          90,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _borderedHeaderCell(BuildContext context, String content, double columnWidth) => Container(
    decoration: const BoxDecoration(
      border: Border(right: BorderSide(color: Colors.grey, width: 0.5)),
    ),
    width: columnWidth,
    alignment: Alignment.center,
    child: Text(
      content,
      softWrap: true,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold),
    ),
  );

  Widget _borderedCell(BuildContext context, String content, double columnWidth) => Container(
    decoration: const BoxDecoration(
      border: Border(right: BorderSide(color: Colors.grey, width: 0.5)),
    ),
    alignment: Alignment.center,
    width: columnWidth,
    child: myTextStyle(context, content),
  );

  myTextStyle(BuildContext context, String content) =>
      Text(content, textAlign: TextAlign.center, softWrap: true, style: Theme.of(context).textTheme.labelMedium);
}
