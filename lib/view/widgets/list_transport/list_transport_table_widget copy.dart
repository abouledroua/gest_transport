import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/listtransport_controller.dart';
import '../../../core/class/transport.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/data.dart';

class ListTransportWidgetTable extends StatelessWidget {
  const ListTransportWidgetTable({super.key});

  @override
  Widget build(BuildContext context) {
    ListTransportsController controller = Get.find<ListTransportsController>();
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowHeight: 60,
            rows: getRow(),
            sortAscending: controller.sort,
            onSelectAll: (value) {},
            sortColumnIndex: controller.sortIndex,
            columnSpacing: 16,
            showCheckboxColumn: true,
            columns: getColumns(context, controller),
          ),
        ),
      ),
    );
  }

  Widget borderedCell(Widget child, {bool drawRight = true}) => Container(
    decoration: BoxDecoration(
      border: Border(right: drawRight ? BorderSide(color: Colors.grey.shade400, width: 1) : BorderSide.none),
    ),
    alignment: Alignment.center,
    child: child,
  );

  getRow() {
    ListTransportsController controller = Get.find<ListTransportsController>();
    final List<Transport> listTransport = controller.transports;
    TextStyle? styleText;
    List<DataRow> rows = [];
    int nb = 0, index = 0;
    for (var item in listTransport) {
      nb++;
      index = listTransport.indexOf(item);
      styleText = (index == controller.selectIndex)
          ? Theme.of(Get.context!).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, color: AppColor.black)
          : Theme.of(Get.context!).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.normal, color: AppColor.black);
      rows.add(
        DataRow(
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
              index = listTransport.indexOf(item);
              controller.selectRow(index);
            }
          },
          cells: [
            DataCell(borderedCell(Text(nb.toString(), style: styleText))),
            DataCell(borderedCell(Text("${item.exercice}/${item.idTransport}", style: styleText))),
            DataCell(borderedCell(Text(item.date, style: styleText))),
            DataCell(borderedCell(Text(item.heure, style: styleText))),
            DataCell(borderedCell(Text(item.nomClient, textAlign: TextAlign.right, style: styleText))),
            DataCell(
              borderedCell(
                Text(
                  AppData.formatPhoneNumber(telNumber1: item.tel1Client, telNumber2: item.tel2Client),
                  style: styleText,
                ),
              ),
            ),
            DataCell(borderedCell(Text("${AppData.formatMoney(item.montantProduit)} DA", style: styleText))),
            DataCell(borderedCell(Text('${AppData.formatMoney(item.montantLivrInterne)} DA', style: styleText))),
            DataCell(borderedCell(Text('${AppData.formatMoney(item.montantLivrExterne)} DA', style: styleText))),
            DataCell(borderedCell(Text('${AppData.formatMoney(item.total)} DA', style: styleText))),
            DataCell(borderedCell(Text(item.nomTransporteurExterne, style: styleText))),
            if (controller.dropEtat == 'Tous'.tr)
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
            DataCell(borderedCell(Text(item.poste, style: styleText))),
            DataCell(borderedCell(Text(item.destination, style: styleText))),
          ],
        ),
      );
    }
    return rows;
  }

  // paginatedTable(ListTransportsController controller, BuildContext context) => PaginatedDataTable(
  //   source: controller.myData,
  //   rowsPerPage: 10,
  //   sortAscending: controller.sort,
  //   onPageChanged: (value) {
  //     controller.resetSelectedIndex();
  //   },
  //   onSelectAll: (value) {},
  //   primary: false,
  //   headingRowHeight: 80,
  //   sortColumnIndex: controller.sortIndex,
  //   showFirstLastButtons: true,
  //   columnSpacing: 26,
  //   showCheckboxColumn: true,
  //   columns: getColumns(context, controller),
  // );

  getColumns(BuildContext context, ListTransportsController controller) => [
    DataColumn(
      label: Text('N°'.tr, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
      numeric: true,
    ),
    DataColumn(
      label: Text('Réf'.tr, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
    ),
    DataColumn(
      label: Text('Date'.tr, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
      onSort: (columnIndex, ascending) {
        controller.onSortColumn(columnIndex, ascending);
      },
    ),
    DataColumn(
      label: Text('Heure'.tr, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
    ),
    DataColumn(
      label: Text('Client'.tr, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
      onSort: (columnIndex, ascending) {
        controller.onSortColumn(columnIndex, ascending);
      },
    ),
    DataColumn(
      label: Text(
        'Télephone'.tr,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Container(
        constraints: const BoxConstraints(maxWidth: 120), // Adjust width as needed
        child: Text(
          'Montant Produit'.tr,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          softWrap: true,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
        ),
      ),
      onSort: (columnIndex, ascending) {
        controller.onSortColumn(columnIndex, ascending);
      },
    ),
    DataColumn(
      label: Container(
        constraints: const BoxConstraints(maxWidth: 120), // Adjust width as needed
        child: Text(
          'Mnt Livr Interne'.tr,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          softWrap: true,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
        ),
      ),
      onSort: (columnIndex, ascending) {
        controller.onSortColumn(columnIndex, ascending);
      },
      tooltip: "Montant de Livraison Interne".tr,
    ),
    DataColumn(
      label: Container(
        constraints: const BoxConstraints(maxWidth: 120), // Adjust width as needed
        child: Text(
          'Mnt Livr Externe'.tr,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          softWrap: true,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
        ),
      ),
      onSort: (columnIndex, ascending) {
        controller.onSortColumn(columnIndex, ascending);
      },
      tooltip: "Montant de Livraison Externe".tr,
    ),
    DataColumn(
      label: Text('Total'.tr, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
      onSort: (columnIndex, ascending) {
        controller.onSortColumn(columnIndex, ascending);
      },
    ),
    DataColumn(
      label: Container(
        constraints: const BoxConstraints(maxWidth: 120), // Adjust width as needed
        child: Text(
          'Transporteur Externe'.tr,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          softWrap: true,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
        ),
      ),
      onSort: (columnIndex, ascending) {
        controller.onSortColumn(columnIndex, ascending);
      },
    ),
    if (controller.dropEtat == 'Tous'.tr)
      DataColumn(
        label: Text('Etat'.tr, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
      ),
    DataColumn(
      label: Text('Poste'.tr, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
    ),
    DataColumn(
      label: Text(
        'Destination'.tr,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
      onSort: (columnIndex, ascending) {
        controller.onSortColumn(columnIndex, ascending);
      },
    ),
  ];
}
