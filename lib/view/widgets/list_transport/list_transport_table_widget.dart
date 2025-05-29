import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import '../../../controller/listtransport_controller.dart';
import '../../../core/class/transport.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/data.dart';

class ListTransportWidgetTable extends StatelessWidget {
  const ListTransportWidgetTable({super.key});

  @override
  Widget build(BuildContext context) {
    ListTransportsController controller = Get.find<ListTransportsController>();
    final rows = controller.transports;
    ScrollController? verticalController;
    return GetBuilder<ListTransportsController>(
      builder: (controller) => Expanded(
        child: Focus(
          autofocus: true,
          onKeyEvent: (FocusNode node, KeyEvent event) => keyboardListener(event, controller, rows, verticalController),
          child: HorizontalDataTable(
            leftHandSideColumnWidth: 70,
            rightHandSideColumnWidth: (controller.dropEtat == 'Tous'.tr) ? 1530 : 1430,
            isFixedHeader: true,
            headerWidgets: _getTitleWidget(context, controller),
            leftSideItemBuilder: (context, index) => GestureDetector(
              onTap: () {
                controller.selectRow(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: getColorRow(controller.transports[index]),
                  border: index == controller.selectIndex
                      ? const Border(
                          top: BorderSide(color: Colors.red, width: 2),
                          right: BorderSide.none,
                          bottom: BorderSide(color: Colors.red, width: 2),
                          left: BorderSide(color: Colors.red, width: 2),
                        )
                      : null,
                ),
                child: _cellText(
                  controller.transports[index].num.toString(),
                  70,
                  _getRowStyle(context, index, controller),
                  index,
                  controller,
                ),
              ),
            ),
            rightSideItemBuilder: (context, index) => _generateAllColumns(controller, index, context),
            itemCount: rows.length,
            rowSeparatorWidget: const Divider(height: 1, color: Colors.grey),
            leftHandSideColBackgroundColor: Colors.white,
            rightHandSideColBackgroundColor: Colors.white,
            onScrollControllerReady: (vc, hc) {
              verticalController = vc;
            },
          ),
        ),
      ),
    );
  }

  getColorRow(item) {
    switch (item.etat) {
      case 4:
        return AppColor.green.withValues(alpha: 0.25);
      case 3:
        return AppColor.red.withValues(alpha: 0.25);
      case 5:
        return AppColor.orange.withValues(alpha: 0.25);
      default:
        return Colors.white;
    }
  }

  KeyEventResult keyboardListener(
    KeyEvent event,
    ListTransportsController controller,
    List<Transport> rows,
    ScrollController? verticalController,
  ) {
    const rowHeight = 62.0; // your row height
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        if (controller.selectIndex < rows.length - 1) {
          controller.selectRow(controller.selectIndex + 1);

          // Scroll only if not visible
          if (verticalController != null) {
            final min = verticalController.offset;
            final max = min + verticalController.position.viewportDimension;
            final rowTop = controller.selectIndex * rowHeight;
            final rowBottom = rowTop + rowHeight;
            if (rowBottom > max) {
              // Scroll down by one row
              verticalController.animateTo(
                min + rowHeight,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            } else if (rowTop < min) {
              // Scroll up by one row (shouldn't happen for down, but for completeness)
              verticalController.animateTo(
                min - rowHeight,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            }
          }
        }
        return KeyEventResult.handled;
      }
      if (event.logicalKey == LogicalKeyboardKey.pageDown) {
        if (controller.selectIndex < rows.length - 7) {
          controller.selectRow(controller.selectIndex + 7);
          if (verticalController != null) {
            final min = verticalController.offset;
            final max = min + verticalController.position.viewportDimension;
            final rowTop = controller.selectIndex * rowHeight;
            final rowBottom = rowTop + rowHeight;
            if (rowBottom > max || rowTop < min) {
              verticalController.animateTo(
                rowTop,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            }
          }
        }
        return KeyEventResult.handled;
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        if (controller.selectIndex > 0) {
          controller.selectRow(controller.selectIndex - 1);

          if (verticalController != null) {
            final min = verticalController.offset;
            final max = min + verticalController.position.viewportDimension;
            final rowTop = controller.selectIndex * rowHeight;
            final rowBottom = rowTop + rowHeight;
            if (rowTop < min) {
              verticalController.animateTo(
                rowTop,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );
            } else if (rowBottom > max) {
              verticalController.animateTo(
                rowTop,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );
            }
          }
        } else {
          controller.selectRow(0);
          if (verticalController != null) {
            verticalController.animateTo(0, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
          }
        }
        return KeyEventResult.handled;
      }
      if (event.logicalKey == LogicalKeyboardKey.pageUp) {
        if (controller.selectIndex > 0) {
          controller.selectRow(controller.selectIndex - 7);
          if (verticalController != null) {
            final min = verticalController.offset;
            final max = min + verticalController.position.viewportDimension;
            final rowTop = controller.selectIndex * rowHeight;
            final rowBottom = rowTop + rowHeight;
            if (rowTop < min || rowBottom > max) {
              verticalController.animateTo(
                rowTop,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            }
          }
        }
        return KeyEventResult.handled;
      }
      if (event.logicalKey == LogicalKeyboardKey.home) {
        if (controller.selectIndex > 0) {
          controller.selectRow(0);
          if (verticalController != null) {
            final min = verticalController.offset;
            final max = min + verticalController.position.viewportDimension;
            final rowTop = controller.selectIndex * rowHeight;
            final rowBottom = rowTop + rowHeight;
            if (rowTop < min || rowBottom > max) {
              verticalController.animateTo(
                rowTop,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            }
          }
        }
        return KeyEventResult.handled;
      }
      if (event.logicalKey == LogicalKeyboardKey.end) {
        if (controller.selectIndex > 0) {
          controller.selectRow(controller.transports.length - 1);
          if (verticalController != null) {
            final min = verticalController.offset;
            final max = min + verticalController.position.viewportDimension;
            final rowTop = controller.selectIndex * rowHeight;
            final rowBottom = rowTop + rowHeight;
            if (rowBottom > max || rowTop < min) {
              verticalController.animateTo(
                rowTop,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            }
          }
        }
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  List<Widget> _getTitleWidget(BuildContext context, ListTransportsController controller) {
    final style = Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold);
    final columns = [
      {'label': 'N°'.tr, 'width': 45.0},
      {'label': 'Réf'.tr, 'width': 110.0},
      {'label': 'Date'.tr, 'width': 105.0},
      {'label': 'Heure'.tr, 'width': 80.0},
      {'label': 'Client'.tr, 'width': 150.0},
      {'label': 'Télephone'.tr, 'width': 120.0},
      {'label': 'Montant Produit'.tr, 'width': 120.0},
      {'label': 'Mnt Livr Interne'.tr, 'width': 120.0},
      {'label': 'Mnt Livr Externe'.tr, 'width': 120.0},
      {'label': 'Total'.tr, 'width': 100.0},
      {'label': 'Transp. Externe'.tr, 'width': 120.0},
      if (controller.dropEtat == 'Tous'.tr) {'label': 'Etat'.tr, 'width': 100.0},
      {'label': 'Poste'.tr, 'width': 100.0},
      {'label': 'Destination'.tr, 'width': 180.0},
    ];

    return columns.map((col) {
      return InkWell(
        onTap: () => controller.sortBy(col['label'] as String),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _headerText(
              col['label'] as String,
              col['width'] as double,
              style.copyWith(color: controller.sortColumn == col['label'] ? Colors.blue : null),
            ),
            if (controller.sortColumn == col['label'])
              Icon(controller.sortAscending ? Icons.arrow_upward : Icons.arrow_downward, size: 16, color: Colors.blue),
          ],
        ),
      );
    }).toList();
  }

  Widget _headerText(String label, double width, TextStyle style) => Container(
    width: width,
    height: 70,
    padding: const EdgeInsets.all(8),
    alignment: Alignment.center,
    child: Text(label, style: style, softWrap: true, textAlign: TextAlign.center),
  );

  Widget _generateAllColumns(ListTransportsController controller, int index, BuildContext context) {
    final item = controller.transports[index];
    final styleText = _getRowStyle(context, index, controller);

    List<Widget> cells = [
      _cellText("${item.exercice}/${item.idTransport}", 110, styleText, index, controller),
      _cellText(item.date, 105, styleText, index, controller),
      _cellText(item.heure, 80, styleText, index, controller),
      _cellText(item.nomClient, 150, styleText, index, controller),
      _cellText(
        AppData.formatPhoneNumber(telNumber1: item.tel1Client, telNumber2: item.tel2Client),
        120,
        styleText,
        index,
        controller,
      ),
      _cellText("${AppData.formatMoney(item.montantProduit)} DA", 120, styleText, index, controller),
      _cellText('${AppData.formatMoney(item.montantLivrInterne)} DA', 120, styleText, index, controller),
      _cellText('${AppData.formatMoney(item.montantLivrExterne)} DA', 120, styleText, index, controller),
      _cellText('${AppData.formatMoney(item.total)} DA', 100, styleText, index, controller),
      _cellText(item.nomTransporteurExterne, 120, styleText, index, controller),
    ];
    if (controller.dropEtat == 'Tous'.tr) {
      cells.add(
        _cellText(
          item.etat == 1
              ? "En Cours".tr
              : item.etat == 2
              ? "Livré Partiellement".tr
              : item.etat == 3
              ? "Annulé".tr
              : item.etat == 4
              ? "Livré Completement".tr
              : "Archivé".tr,
          100,
          styleText,
          index,
          controller,
        ),
      );
    }
    cells.add(_cellText(item.poste, 100, styleText, index, controller));
    cells.add(_cellText(item.destination, 180, styleText, index, controller));
    return GestureDetector(
      onTap: () {
        controller.selectRow(index);
      },
      child: Container(
        decoration: BoxDecoration(
          color: getColorRow(item),
          border: index == controller.selectIndex
              ? const Border(
                  top: BorderSide(color: Colors.red, width: 2),
                  right: BorderSide(color: Colors.red, width: 2),
                  bottom: BorderSide(color: Colors.red, width: 2),
                  left: BorderSide.none,
                )
              : null,
        ),
        child: Row(children: cells),
      ),
    );
  }

  TextStyle _getRowStyle(BuildContext context, int index, ListTransportsController controller) =>
      (index == controller.selectIndex)
      ? Theme.of(Get.context!).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, color: AppColor.black)
      : Theme.of(Get.context!).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.normal, color: AppColor.black);

  Widget _cellText(String text, double width, TextStyle? style, int index, ListTransportsController controller) =>
      Container(
        width: width,
        height: index == controller.selectIndex ? 75 : 62, // Set a fixed height
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(text, style: style, softWrap: true, textAlign: TextAlign.center),
      );
}
