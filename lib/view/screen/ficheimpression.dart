import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../core/constant/color.dart';
import 'mywidget.dart';

class FicheImpression extends StatelessWidget {
  const FicheImpression({super.key});

  @override
  Widget build(BuildContext context) => MyWidget(
    backgroundColor: AppColor.white,
    appBarColor: AppColor.primary,
    leadingIconColor: AppColor.white,
    title: " Aperçu Avant Impression ",
    child: PdfPreview(
      build: (format) => Get.arguments['DOC'].save(),
      canChangePageFormat: true,
      allowPrinting: true,
      canChangeOrientation: false,
      pageFormats: {'Page Compléte (A4)': PdfPageFormat.a4, 'Demi Page (A5)': PdfPageFormat.a5},
      allowSharing: true,
      initialPageFormat: Get.arguments['PAGE_FORMAT'] ?? PdfPageFormat.a4,
      pdfFileName: '${Get.arguments['TITLE']}.pdf',
    ),
  );
}
