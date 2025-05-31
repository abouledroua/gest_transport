import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/listtransport_controller.dart';
import '../../../core/class/transport.dart';
import '../../../core/constant/data.dart';
import '../../../core/constant/sizes.dart';
import '../loadingbarwidget.dart';

class DetailsTableWidget extends StatelessWidget {
  final Transport item;
  const DetailsTableWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListTransportsController());
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Spacer(),
            Text(
              'Détails du transport'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.clear),
            ),
          ],
        ),
        Divider(),
        Row(
          children: [
            Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
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
            Spacer(),
            Row(
              children: [
                Text(
                  '${'Date'.tr}:',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(' ${item.date}', textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Text(
                  '${'Client'.tr}:',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(' ${item.nomClient}', textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
            Spacer(),
          ],
        ),
        Divider(),
        Obx(
          () => (controller.loadingDetails.value)
              ? LoadingBarWidget()
              : (controller.detailTransport.isEmpty)
              ? Center(
                  child: Text(
                    'Liste_vide'.tr,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.red),
                  ),
                )
              : myTable(context, controller),
        ),
      ],
    );
  }

  SizedBox myTable(BuildContext context, ListTransportsController controller) => SizedBox(
    height: min(AppSizes.heightScreen - 40, 140 + (controller.detailTransport.length - 1) * 50),
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
          rows: controller.detailTransport
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

  Text myTextStyle(BuildContext context, String content) =>
      Text(content, textAlign: TextAlign.center, softWrap: true, style: Theme.of(context).textTheme.labelMedium);
}
