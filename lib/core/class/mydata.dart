import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/listtransport_controller.dart';
import '../constant/color.dart';
import '../constant/data.dart';
import 'transport.dart';

class MyData extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    ListTransportsController controller = Get.find();
    final List<Transport> listTransport = controller.transports;
    Transport item = listTransport[index];
    TextStyle? styleText = (index == controller.selectIndex)
        ? Theme.of(Get.context!).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, color: AppColor.black)
        : Theme.of(
            Get.context!,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.normal, color: AppColor.greyblack);
    return DataRow(
      color: WidgetStateProperty.all<Color>(
        item.etat == 1
            ? Colors.transparent
            : item.etat == 2
            ? AppColor.yellow
            : item.etat == 3
            ? AppColor.red
            : item.etat == 4
            ? AppColor.greenClair
            : AppColor.amber,
      ),
      selected: (index == controller.selectIndex),
      onSelectChanged: (value) {
        if (value != null && value) {
          controller.selectRow(index);
        }
      },
      cells: [
        DataCell(Text(item.idTransport.toString(), style: styleText)),
        DataCell(Text("${item.exercice}/${item.idTransport}", style: styleText)),
        DataCell(Text(item.date, style: styleText)),
        DataCell(Text(item.heure, style: styleText)),
        DataCell(Text(item.nomClient, textAlign: TextAlign.right, style: styleText)),
        DataCell(
          Text(
            AppData.formatPhoneNumber(telNumber1: item.tel1Client, telNumber2: item.tel2Client),
            style: styleText,
          ),
        ),
        DataCell(Text("${AppData.formatMoney(item.montantProduit)} DA", style: styleText)),
        DataCell(Text('${AppData.formatMoney(item.montantLivrInterne)} DA', style: styleText)),
        DataCell(Text('${AppData.formatMoney(item.montantLivrExterne)} DA', style: styleText)),
        DataCell(Text('${AppData.formatMoney(item.total)} DA', style: styleText)),
        DataCell(Text(item.nomTransporteurExterne, style: styleText)),
        DataCell(
          Text(
            item.etat == 1
                ? "En Cours".tr
                : item.etat == 2
                ? "Livré Partiellement".tr
                : item.etat == 3
                ? "Annulé".tr
                : item.etat == 4
                ? "Livré Completement".tr
                : "Archivé".tr,
            style: styleText,
          ),
        ),
        DataCell(Text(item.poste, style: styleText)),
        DataCell(Text(item.destination, style: styleText)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount {
    ListTransportsController controller = Get.find();
    return controller.transports.length;
  }

  @override
  int get selectedRowCount => 0;
}
