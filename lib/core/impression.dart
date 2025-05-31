import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../controller/parametre_controller.dart';
import 'class/transport.dart';

// getEnteteInfo_1(MyMagasin magasin) {
//   String enteteInfo1 = magasin.rc.isNotEmpty ? 'RC : ${magasin.rc}' : '';
//   enteteInfo1 += magasin.nif.isNotEmpty ? '${enteteInfo1.isNotEmpty ? '  **  ' : ''}I. Fiscal : ${magasin.nif}' : '';

//   String ligne1 = magasin.ai.isNotEmpty ? 'AI : ${magasin.ai}' : '';
//   ligne1 += magasin.nis.isNotEmpty ? '${ligne1.isNotEmpty ? '  **  ' : ''}NIS : ${magasin.nis}' : '';

//   if (ligne1.isNotEmpty) {
//     enteteInfo1 += '\n$ligne1';
//   }

//   String enteteInfo2 = magasin.tel.isNotEmpty ? 'Tel/Fax : ${magasin.tel}' : '';
//   enteteInfo2 += magasin.email.isNotEmpty ? '${enteteInfo2.isNotEmpty ? '\n' : ''}E-mail : ${magasin.email}' : '';

//   ligne1 = magasin.nomBanque.isNotEmpty ? 'Banque : ${magasin.nomBanque}' : '';
//   ligne1 += magasin.rib.isNotEmpty ? '${ligne1.isNotEmpty ? '  **  ' : ''}RIB : ${magasin.rib}' : '';
//   ligne1 += magasin.numBanque.isNotEmpty ? '${ligne1.isNotEmpty ? '  **  ' : ''}N° compte : ${magasin.numBanque}' : '';

//   if (ligne1.isNotEmpty) {
//     enteteInfo2 += '\n$ligne1';
//   }

//   return (enteteInfo1, enteteInfo2);
// }

// getLogo(MyMagasin magasin) async {
//   try {
//     String logoLink =
//         '${AppData.getServerName()}/COMMERCIAL/WWW/IMAGES/logo_${AppData.miniDossier}_${magasin.id}.${magasin.extLogoMobile}?d=${DateTime.now()}';
//     return await networkImage(logoLink);
//   } catch (e) {
//     if (kDebugMode) {
//       debugPrint("**** ERROR getLogo : $e****");
//     }
//   }
//   return null;
// }

// getCacher(MyMagasin magasin) async {
//   try {
//     String cacherLink =
//         '${AppData.getServerName()}/COMMERCIAL/WWW/IMAGES/cacher_${AppData.miniDossier}_${magasin.id}.${magasin.extCacherMobile}?d=${DateTime.now()}';
//     return await networkImage(cacherLink);
//   } catch (e) {
//     if (kDebugMode) {
//       debugPrint("****ERROR cacherLink : $e****");
//     }
//   }
//   return null;
// }

// getEntete({required MyMagasin magasin, String? dateFacture, Personne? person}) async =>
//     magasin.modelImpr == 10 ? getEntete_10(magasin, dateFacture, person) : getEntete_1(magasin);

// getEnteteMini({required MyMagasin magasin, String? dateFacture, Personne? person}) async =>
//     magasin.modelImpr == 10 ? getEnteteMini_10(magasin, dateFacture, person) : getEnteteMini_1(magasin);

pw.Column getEntete() {
  ParametreController param = Get.find();
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Center(
        child: pw.Text(
          param.nomMagasin,
          textAlign: pw.TextAlign.center,
          textDirection: pw.TextDirection.rtl,
          style: pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold),
        ),
      ),
      if (param.activiteMagasin.isNotEmpty)
        pw.Center(
          child: pw.Text(
            param.activiteMagasin,
            textAlign: pw.TextAlign.center,
            textDirection: pw.TextDirection.rtl,
            style: pw.TextStyle(fontSize: 22),
          ),
        ),
      if (param.adrMagasin.isNotEmpty)
        pw.Center(
          child: pw.Text(
            param.adrMagasin,
            textAlign: pw.TextAlign.center,
            textDirection: pw.TextDirection.rtl,
            style: pw.TextStyle(fontSize: 20),
          ),
        ),
      if (param.telMagasin.isNotEmpty)
        pw.Center(
          child: pw.Text(
            param.telMagasin,
            textAlign: pw.TextAlign.center,
            textDirection: pw.TextDirection.rtl,
            style: pw.TextStyle(fontSize: 19),
          ),
        ),
    ],
  );
}

// getEntete_10(MyMagasin magasin, String? dateFacture, Personne? item) async {
//   pw.ImageProvider? logo = await getLogo(magasin);
//   return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//     pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
//       (logo != null) ? pw.Image(logo, height: 100) : pw.Container(),
//       if (dateFacture != null)
//         pw.Text('Date : $dateFacture',
//             style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 14, fontWeight: pw.FontWeight.bold)),
//     ]),
//     pw.SizedBox(height: 10),
//     pw.Container(
//         padding: pw.EdgeInsets.symmetric(vertical: 6, horizontal: 6),
//         decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColor.fromInt(0xff000000))),
//         child: pw.Row(
//             mainAxisAlignment: pw.MainAxisAlignment.start,
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Expanded(
//                   flex: 8,
//                   child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//                     pw.Text(magasin.nomEntreprise, style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                     if (magasin.adresse.isNotEmpty)
//                       pw.Text('Adresse : ${magasin.adresse}', style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                     if (magasin.rc.isNotEmpty)
//                       pw.Text('N° Reg. Com : ${magasin.rc}', style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                     if (magasin.ai.isNotEmpty)
//                       pw.Text('Article Fiscal : ${magasin.ai}',
//                           style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                     if (magasin.nif.isNotEmpty)
//                       pw.Text('N.I.F : ${magasin.nif}', style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                     if (magasin.nis.isNotEmpty)
//                       pw.Text('N.I.S : ${magasin.nis}', style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                   ])),
//               pw.SizedBox(width: 10),
//               if (item != null)
//                 pw.Expanded(
//                     flex: 7,
//                     child: pw.Column(
//                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         mainAxisAlignment: pw.MainAxisAlignment.start,
//                         children: [
//                           pw.Text('A :     ${item.nom}', style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                           if (item.adresse.isNotEmpty)
//                             pw.Text('Adresse : ${item.adresse}',
//                                 style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                           if (item.rc.isNotEmpty)
//                             pw.Text('N° Reg. Com : ${item.rc}',
//                                 style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                           if (item.article.isNotEmpty)
//                             pw.Text('Article Fiscal : ${item.article}',
//                                 style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                           if (item.nif.isNotEmpty)
//                             pw.Text('N.I.F : ${item.nif}', style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                           if (item.nis.isNotEmpty)
//                             pw.Text('N.I.S : ${item.nis}', style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                           pw.SizedBox(height: 10),
//                           pw.Text('CODE CLIENT : CL${item.id}',
//                               style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                         ]))
//             ]))
//   ]);
// }

// getEnteteMini_1(MyMagasin magasin) async {
//   pw.ImageProvider? logo = await getLogo(magasin);
//   return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//     pw.Container(
//         padding: pw.EdgeInsets.symmetric(horizontal: 10),
//         decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColor.fromInt(0xff000000))),
//         child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
//           pw.Expanded(
//               child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//             pw.Text(magasin.nomEntreprise, style: pw.TextStyle(font: AppData.ttfSogoe, fontSize: 18)),
//             pw.Text('Activité : ${magasin.activite}',
//                 style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 14, fontWeight: pw.FontWeight.bold)),
//             pw.Text(
//                 'Siège social : ${magasin.adresse} ${magasin.capital.isNotEmpty ? 'CAPITAL social : ${magasin.capital}' : ''}',
//                 style: pw.TextStyle(font: pw.Font.times(), fontSize: 14))
//           ])),
//           if (logo != null) pw.Image(logo, height: 80)
//         ]))
//   ]);
// }

// getEnteteMini_10(MyMagasin magasin, String? dateFacture, Personne? item) async {
//   pw.ImageProvider? logo = await getLogo(magasin);
//   return pw.Container(
//       padding: pw.EdgeInsets.symmetric(vertical: 6, horizontal: 6),
//       decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColor.fromInt(0xff000000))),
//       child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//         pw.Row(children: [
//           (logo != null) ? pw.Image(logo, height: 100) : pw.Container(),
//           pw.SizedBox(width: 20),
//           pw.Expanded(
//               child: pw.Row(
//                   mainAxisAlignment: pw.MainAxisAlignment.start,
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                 pw.Expanded(
//                     flex: 8,
//                     child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//                       pw.Text(magasin.nomEntreprise, style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                       if (magasin.adresse.isNotEmpty)
//                         pw.Text('Adresse : ${magasin.adresse}',
//                             style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                       if (magasin.rc.isNotEmpty)
//                         pw.Text('N° Reg. Com : ${magasin.rc}',
//                             style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                       if (magasin.ai.isNotEmpty)
//                         pw.Text('Article Fiscal : ${magasin.ai}',
//                             style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                       if (magasin.nif.isNotEmpty)
//                         pw.Text('N.I.F : ${magasin.nif}', style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                       if (magasin.nis.isNotEmpty)
//                         pw.Text('N.I.S : ${magasin.nis}', style: pw.TextStyle(font: pw.Font.times(), fontSize: 14)),
//                     ]))
//               ]))
//         ])
//       ]));
// }

// // **********   Impression Bon Transport **********

// String getLibeleFacture(int type, MyMagasin magasin) => type == 1
//     ? 'Bon de Réception'
//     : type == 2
//         ? 'Facture d\'Achat'
//         : type == 3
//             ? magasin.libFactureProforma
//             : type == 4 || type == 7
//                 ? 'Bon de Commande'
//                 : type == 5
//                     ? 'Bon de Livraison'
//                     : magasin.libFactureVente;

// List<pw.Widget> getFacturePdf(entete, MyMagasin magasin, Facture item, int type, bool existPrix,
//         List<List<String>> data, pw.ImageProvider? cacher, pw.Context context) =>
//     magasin.modelImpr == 10
//         ? facture_10(entete, magasin, item, type, existPrix, data, cacher, context)
//         : facture_1(entete, magasin, item, type, existPrix, data, cacher, context);

List<pw.Widget> getBonTransport(
  Transport item,
  List<List<String>> data,
  pw.Context context,
  pw.MemoryImage phoneImage,
) {
  ParametreController param = Get.find();
  return [
    getEntete(),
    pw.Divider(),
    pw.Center(
      child: pw.Text(
        'transport'.tr,
        textAlign: pw.TextAlign.center,
        textDirection: pw.TextDirection.rtl,
        style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold, decoration: pw.TextDecoration.underline),
      ),
    ),
    pw.Row(
      children: [
        pw.Text(
          '${'Date'.tr} : ',
          textAlign: pw.TextAlign.center,
          textDirection: pw.TextDirection.rtl,
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          item.date,
          textAlign: pw.TextAlign.center,
          textDirection: pw.TextDirection.rtl,
          style: pw.TextStyle(fontSize: 24),
        ),
      ],
    ),
    pw.Row(
      children: [
        pw.Text(
          '${'Client'.tr} : ',
          textAlign: pw.TextAlign.center,
          textDirection: pw.TextDirection.rtl,
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          item.nomClient,
          textAlign: pw.TextAlign.center,
          textDirection: pw.TextDirection.rtl,
          style: pw.TextStyle(fontSize: 24),
        ),
      ],
    ),
    pw.Row(
      children: [
        pw.Text(
          '${'Télephone'.tr} : ',
          textAlign: pw.TextAlign.center,
          textDirection: pw.TextDirection.rtl,
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          item.tel1Client +
              (item.tel2Client.isNotEmpty ? ((item.tel1Client.isNotEmpty) ? " / " : "") + item.tel2Client : ""),
          textAlign: pw.TextAlign.center,
          textDirection: pw.TextDirection.rtl,
          style: pw.TextStyle(fontSize: 38),
        ),
      ],
    ),

    pw.Table(
      border: pw.TableBorder.all(),
      columnWidths: {
        0: pw.FlexColumnWidth(3),
        1: pw.FlexColumnWidth(2),
        2: pw.FlexColumnWidth(2),
        3: pw.FlexColumnWidth(2),
      },
      children: [
        // Header row
        pw.TableRow(
          decoration: pw.BoxDecoration(color: PdfColor.fromHex('DBDBDB')),
          children: [
            for (final header in [
              'Fournisseur'.tr,
              'Quantité'.tr,
              'Montant Transport Externe'.tr,
              'Montant Produit'.tr,
            ])
              pw.Container(
                alignment: pw.Alignment.center,
                padding: const pw.EdgeInsets.symmetric(vertical: 6),
                child: pw.Text(
                  header,
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 22),
                  textDirection: pw.TextDirection.rtl,
                ),
              ),
          ],
        ),
        // Data rows
        ...data.map(
          (row) => pw.TableRow(
            children: [
              for (final cell in row)
                pw.Container(
                  alignment: pw.Alignment.center,
                  padding: const pw.EdgeInsets.symmetric(vertical: 12),
                  child: pw.Text(cell, style: pw.TextStyle(fontSize: 20), textDirection: pw.TextDirection.rtl),
                ),
            ],
          ),
        ),
      ],
    ),
    pw.SizedBox(height: 10),
    pw.Row(
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Row(
                children: [
                  pw.SizedBox(width: 50),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(width: 4),
                      borderRadius: pw.BorderRadius.circular(8),
                    ),
                    padding: pw.EdgeInsets.all(10),
                    child: pw.BarcodeWidget(
                      width: 200,
                      height: 35,
                      barcode: pw.Barcode.code128(),
                      data: 'T${item.idTransport}/${item.exercice}',
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 6),
              pw.Row(
                children: [
                  pw.SizedBox(width: 15),
                  pw.Image(phoneImage, width: 35, height: 35),
                  pw.SizedBox(width: 8),
                  pw.Container(
                    width: 200,
                    height: 35,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(width: 4, color: PdfColor.fromHex('3DFF53')),
                      borderRadius: pw.BorderRadius.circular(8),
                    ),
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Text(param.fixMagasin, textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 22)),
                  ),
                ],
              ),
              pw.SizedBox(height: 6),
              pw.Center(
                child: pw.Text(
                  'Developper'.tr,
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontSize: 14, color: PdfColor.fromHex('505050')),
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.BarcodeWidget(
            width: 100,
            height: 100,
            barcode: pw.Barcode.qrCode(),
            data:
                'تـــــوفيق العنـــــــابي للنقـــل\nEULMA (0561 639 094 // 0782 234 232)\nنقل البضـائع\nANNABA (0561 636 292 // 0779 362 846)\nBON DE TRANSPORT',
          ),
        ),
      ],
    ),
    // if (type != 5 || magasin.imprNumBl)
    //   pw.Center(
    //     child: pw.Text(
    //       'N° : ${item.num}',
    //       textAlign: pw.TextAlign.center,
    //       style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 14),
    //     ),
    //   ),
    // pw.Row(
    //   mainAxisAlignment: pw.MainAxisAlignment.end,
    //   children: [
    //     pw.Text(
    //       '${magasin.villeFr.isNotEmpty ? '${magasin.villeFr}, le ' : ''} ${item.date}',
    //       textAlign: pw.TextAlign.end,
    //       style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10),
    //     ),
    //   ],
    // ),
    // pw.SizedBox(height: 10),
    // getPersonPrint(item, type),
    // pw.SizedBox(height: 10),
    //
    // pw.SizedBox(height: 2),
    // getMontantTotalPrint(item),
    // pw.SizedBox(height: 10),
    // pw.Text(
    //   'Arrêté le total du présent ${getLibeleFacture(type, magasin).toLowerCase()} à la somme de : ',
    //   style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 8, decoration: pw.TextDecoration.underline),
    // ),
    // pw.Text(NumberToWords.convert(item.ttc), style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 8)),
    // ...foorterFacture(magasin, cacher, item),
  ];
}

// List<pw.Widget> facture_10(
//   entete,
//   MyMagasin magasin,
//   Facture item,
//   int type,
//   bool existPrix,
//   List<List<String>> data,
//   pw.ImageProvider? cacher,
//   pw.Context context,
// ) => [
//   entete,
//   pw.SizedBox(height: 10),
//   pw.Center(
//     child: pw.Text(
//       '${getLibeleFacture(type, magasin)} ${type != 5 || magasin.imprNumBl ? 'N° : ${item.num}' : ''}',
//       textAlign: pw.TextAlign.center,
//       style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 14),
//     ),
//   ),
//   pw.SizedBox(height: 10),
//   if (type == 3 && item.objet.isNotEmpty)
//     pw.Row(
//       children: [
//         pw.Text(
//           'Objet : ',
//           style: pw.TextStyle(font: pw.Font.times(), fontSize: 12, decoration: pw.TextDecoration.underline),
//         ),
//         pw.Text(item.objet, style: pw.TextStyle(font: pw.Font.times(), fontSize: 12)),
//       ],
//     ),
//   pw.SizedBox(height: 10),
//   pw.TableHelper.fromTextArray(
//     columnWidths: {
//       0: pw.FlexColumnWidth(3),
//       1: pw.FlexColumnWidth(existPrix ? 9 : 18),
//       2: pw.FlexColumnWidth((magasin.imprUM) ? 3 : 0),
//       3: pw.FlexColumnWidth(3),
//       4: pw.FlexColumnWidth(existPrix ? 3 : 0),
//       5: pw.FlexColumnWidth(existPrix ? 5 : 0),
//     },
//     headerCellDecoration: pw.BoxDecoration(color: PdfColor.fromHex('FFE4BC')),
//     headers: ['Référence', 'Designation', 'U . M', 'Quantité', 'Prix Unit', 'Montant DA (HT)'],
//     cellStyle: pw.TextStyle(font: pw.Font.times(), fontSize: 8),
//     cellPadding: pw.EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//     headerAlignment: pw.Alignment.center,
//     cellAlignments: {
//       0: pw.AlignmentDirectional.centerStart,
//       1: pw.AlignmentDirectional.topStart,
//       2: pw.AlignmentDirectional.center,
//       3: pw.AlignmentDirectional.center,
//       4: pw.AlignmentDirectional.centerEnd,
//       5: pw.AlignmentDirectional.centerEnd,
//     },
//     headerStyle: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 8),
//     data: data,
//   ),
//   pw.SizedBox(height: 2),
//   getMontantTotalPrint(item),
//   pw.SizedBox(height: 10),
//   pw.Text(
//     'Arrêté le total du présent ${getLibeleFacture(type, magasin).toLowerCase()} à la somme de : ',
//     style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 8, decoration: pw.TextDecoration.underline),
//   ),
//   pw.Text(NumberToWords.convert(item.ttc), style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 8)),
//   ...foorterFacture(magasin, cacher, item),
// ];

// List<pw.Widget> foorterFacture(MyMagasin magasin, pw.ImageProvider? cacher, Facture item) => [
//       pw.SizedBox(height: 20),
//       pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
//         pw.Padding(
//             padding: pw.EdgeInsets.only(left: 30),
//             child: pw.Text(magasin.signature == 1 ? 'Visa et Signature\nEmmetteur     ' : '',
//                 textAlign: pw.TextAlign.end, style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 12))),
//         pw.Padding(
//             padding: pw.EdgeInsets.only(right: 30),
//             child: pw.Text('Visa et Signature${magasin.signature == 1 ? '\nRécepteur    ' : ''}',
//                 textAlign: pw.TextAlign.end, style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 12)))
//       ]),
//       pw.SizedBox(height: 10),
//       pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           children: [pw.Text(item.basPage), if (cacher != null) pw.Image(cacher, height: 130)]),
//       pw.SizedBox(height: 5)
//     ];

// getPersonPrint(Facture item, int type) => pw.Row(
//         mainAxisAlignment: type == 1 || type == 2 || type == 7 ? pw.MainAxisAlignment.start : pw.MainAxisAlignment.end,
//         children: [
//           pw.Container(
//               width: 260,
//               padding: pw.EdgeInsets.all(2),
//               decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColor.fromInt(0xff000000))),
//               child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//                 pw.Text(
//                     type == 1 || type == 2 || type == 7
//                         ? 'Fournisseur :'
//                         : type == 3 || type == 6 || type == 4
//                             ? 'Client : '
//                             : 'Déstinataire :',
//                     style:
//                         pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10, decoration: pw.TextDecoration.underline)),
//                 pw.Text('Nom / Raison Social : ${item.nomClient}',
//                     style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10)),
//                 if (item.adrClient.isNotEmpty)
//                   pw.Text(item.adrClient, style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10)),
//                 if (item.rcClient.isNotEmpty)
//                   pw.Text('     RC : ${item.rcClient}', style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10)),
//                 if (item.nisClient.isNotEmpty)
//                   pw.Text('     NIS : ${item.nisClient}', style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10)),
//                 if (item.nifClient.isNotEmpty)
//                   pw.Text('     NIF : ${item.nifClient}', style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10)),
//                 if (item.artClient.isNotEmpty)
//                   pw.Text('     ART : ${item.artClient}', style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10)),
//                 if (item.telClient.isNotEmpty)
//                   pw.Text('     TEL : ${item.telClient}', style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10)),
//               ]))
//         ]);

// getMontantTotalPrint(Facture item) => pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
//       pw.Container(
//           width: 260,
//           padding: pw.EdgeInsets.all(2),
//           decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColor.fromInt(0xff000000))),
//           child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//             pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
//               pw.Text((item.tvaPourc > 0) ? 'Total HT' : 'Total',
//                   textAlign: pw.TextAlign.end, style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10)),
//               pw.Text('${AppData.formatMoney(item.ht)} DA',
//                   textAlign: pw.TextAlign.end, style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10))
//             ]),
//             if (item.tvaPourc > 0)
//               pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
//                 pw.Text('TVA (${item.tvaPourc * 100}%)',
//                     textAlign: pw.TextAlign.end, style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10)),
//                 pw.Text('${AppData.formatMoney(item.tva)} DA',
//                     textAlign: pw.TextAlign.end, style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10))
//               ]),
//             if (item.tvaPourc > 0)
//               pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
//                 pw.Text('Total TTC',
//                     textAlign: pw.TextAlign.end, style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10)),
//                 pw.Text('${AppData.formatMoney(item.ttc)} DA',
//                     textAlign: pw.TextAlign.end, style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10))
//               ])
//           ]))
//     ]);

// // **********   Impression Details Personne **********

// List<pw.Widget> getDetailsPersonPdf(entete, MyMagasin magasin, int type, bool existPrix, List<List<String>> data,
//         pw.ImageProvider? cacher, String nomPersonne, double dette) =>
//     [
//       entete,
//       pw.SizedBox(height: 10),
//       pw.Center(
//           child: pw.Text("Détails ${type == 1 ? 'Client' : 'Fournisseur'}",
//               textAlign: pw.TextAlign.center, style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 14))),
//       if (magasin.modelImpr == 1)
//         pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
//           pw.Text(
//               '${magasin.villeFr.isNotEmpty ? '${magasin.villeFr}, le : ' : ''}${DateTime.now().toString().substring(0, 10)}',
//               textAlign: pw.TextAlign.end,
//               style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10))
//         ]),
//       if (magasin.modelImpr == 1) pw.SizedBox(height: 10),
//       if (magasin.modelImpr == 1)
//         pw.Row(
//             mainAxisAlignment: type == 1 || type == 2 ? pw.MainAxisAlignment.start : pw.MainAxisAlignment.end,
//             children: [
//               pw.Container(
//                   width: 260,
//                   padding: pw.EdgeInsets.all(2),
//                   decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColor.fromInt(0xff000000))),
//                   child: pw.Text('${type == 2 ? 'Fournisseur' : 'Client'} : $nomPersonne',
//                       style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10)))
//             ]),
//       pw.SizedBox(height: 10),
//       pw.TableHelper.fromTextArray(
//           columnWidths: {
//             0: pw.FlexColumnWidth(3),
//             1: pw.FlexColumnWidth(3),
//             2: pw.FlexColumnWidth(4),
//             3: pw.FlexColumnWidth(9),
//             4: pw.FlexColumnWidth(2),
//             5: pw.FlexColumnWidth(3),
//             6: pw.FlexColumnWidth(3),
//             7: pw.FlexColumnWidth(3),
//             8: pw.FlexColumnWidth(0)
//           },
//           headerCellDecoration: pw.BoxDecoration(color: PdfColor.fromHex('DBDBDB')),
//           headers: ['N°', 'Date', 'Dépôt', 'Désignation', 'Qte', 'PU', 'Montant', 'Solde', 'Type'],
//           cellDecoration: (index, datas, rowNum) {
//             String type = data[rowNum - 1][8];
//             return pw.BoxDecoration(
//                 color: (type == "1")
//                     ? PdfColor.fromHex('FFFFFF')
//                     : (type == "2")
//                         ? PdfColor.fromHex('6AFF3D')
//                         : (type == "3")
//                             ? PdfColor.fromHex('F5FF42')
//                             : PdfColor.fromHex('FFB7BE'));
//           },
//           cellStyle: pw.TextStyle(font: pw.Font.times(), fontSize: 8),
//           cellPadding: pw.EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//           headerAlignment: pw.Alignment.center,
//           cellAlignments: {
//             0: pw.AlignmentDirectional.topEnd,
//             1: pw.AlignmentDirectional.topCenter,
//             2: pw.AlignmentDirectional.topStart,
//             3: pw.AlignmentDirectional.topStart,
//             4: pw.AlignmentDirectional.topEnd,
//             5: pw.AlignmentDirectional.topEnd,
//             6: pw.AlignmentDirectional.topEnd,
//             7: pw.AlignmentDirectional.topEnd
//           },
//           headerStyle: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 8),
//           data: data),
//       pw.SizedBox(height: 10),
//       pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
//         pw.Text('Reste à Payé = ${AppData.formatMoney(dette)} DA',
//             style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 12))
//       ]),
//       pw.SizedBox(height: 10),
//       ...footerDetailsPerson(cacher)
//     ];

// footerDetailsPerson(pw.ImageProvider? cacher) => [
//       pw.SizedBox(height: 10),
//       pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
//         pw.Padding(
//             padding: pw.EdgeInsets.only(right: 30),
//             child: pw.Text('Visa et Signature',
//                 textAlign: pw.TextAlign.end, style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 12)))
//       ]),
//       pw.SizedBox(height: 10),
//       if (cacher != null) pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [pw.Image(cacher, height: 130)])
//     ];

// // **********   Impression Réglement **********

// List<pw.Widget> getReglementPdf(entete, MyMagasin magasin, int typePerson, int typeOperation, pw.ImageProvider? cacher,
//         Reglement reglement, MyUserController userController) =>
//     [
//       entete,
//       pw.SizedBox(height: 10),
//       pw.Center(
//           child: pw.Text(
//               "${typeOperation == 1 ? 'Réglement' : 'Rembourssement'} ${typePerson == 1 ? 'Client' : 'Fournisseur'}",
//               textAlign: pw.TextAlign.center,
//               style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 14))),
//       pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
//         pw.Text('${magasin.villeFr.isNotEmpty ? '${magasin.villeFr}, le : ' : ''}${reglement.date}',
//             textAlign: pw.TextAlign.end, style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 10))
//       ]),
//       pw.SizedBox(height: 10),
//       pw.Row(
//           mainAxisAlignment: typePerson == 1 || typePerson == 2 ? pw.MainAxisAlignment.start : pw.MainAxisAlignment.end,
//           children: [
//             pw.Text('${typePerson == 2 ? 'Fournisseur' : 'Client'} : ',
//                 style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 12)),
//             pw.Text(reglement.nomPersonne, style: pw.TextStyle(font: pw.Font.times(), fontSize: 12)),
//           ]),
//       pw.SizedBox(height: 10),
//       pw.Row(
//           mainAxisAlignment: typePerson == 1 || typePerson == 2 ? pw.MainAxisAlignment.start : pw.MainAxisAlignment.end,
//           children: [
//             pw.Text('Montant : ', style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 12)),
//             pw.Text('${AppData.formatMoney(reglement.montant)} DA',
//                 style: pw.TextStyle(font: pw.Font.times(), fontSize: 12)),
//           ]),
//       pw.SizedBox(height: 10),
//       if ((typePerson == 1 && userController.voirDetteClient) ||
//           (typePerson == 2 && userController.voirDetteFournisseur))
//         pw.Row(
//             mainAxisAlignment:
//                 typePerson == 1 || typePerson == 2 ? pw.MainAxisAlignment.start : pw.MainAxisAlignment.end,
//             children: [
//               pw.Text('Montant ancien de la dette : ', style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 12)),
//               pw.Text(
//                   '${AppData.formatMoney(typeOperation == 1 ? reglement.dette + reglement.montant : reglement.dette - reglement.montant)} DA',
//                   style: pw.TextStyle(font: pw.Font.times(), fontSize: 12)),
//             ]),
//       if ((typePerson == 1 && userController.voirDetteClient) ||
//           (typePerson == 2 && userController.voirDetteFournisseur))
//         pw.SizedBox(height: 10),
//       if ((typePerson == 1 && userController.voirDetteClient) ||
//           (typePerson == 2 && userController.voirDetteFournisseur))
//         pw.Row(
//             mainAxisAlignment:
//                 typePerson == 1 || typePerson == 2 ? pw.MainAxisAlignment.start : pw.MainAxisAlignment.end,
//             children: [
//               pw.Text('Montant nouveau de la dette : ', style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 13)),
//               pw.Text('${AppData.formatMoney(reglement.dette)} DA',
//                   style: pw.TextStyle(font: pw.Font.times(), fontSize: 13)),
//             ]),
//       pw.SizedBox(height: 10),
//       ...footerDetailsPerson(cacher)
//     ];

// // **********   Impression Pv Sortie Chantier **********

// myTextLabel({required String label, required String value}) =>
//     pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.start, children: [
//       pw.Text(label, textAlign: pw.TextAlign.center, style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 12)),
//       pw.Text(value.isEmpty ? ' / ' : value, style: pw.TextStyle(font: pw.Font.times(), fontSize: 12))
//     ]);

// List<pw.Widget> impressionPvSortieChantier(
//     PvSortieChantier item, pw.Context context, pw.ImageProvider? cacher, entete) {
//   double height = 6;
//   return [
//     pw.SizedBox(height: height),
//     entete,
//     pw.SizedBox(height: height),
//     pw.Center(
//         child: pw.Text('PV Sortie Chantier',
//             textAlign: pw.TextAlign.center, style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 14))),
//     pw.SizedBox(height: height * 2),
//     pw.Container(
//         width: double.infinity,
//         padding: pw.EdgeInsets.all(height),
//         decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColor.fromInt(0xff000000))),
//         child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//           myTextLabel(label: 'Date de visite : ', value: item.datePv),
//           pw.SizedBox(height: height),
//           myTextLabel(label: 'Technico-Commercial : ', value: item.technicoCommercial),
//           pw.SizedBox(height: height),
//           pw.Row(children: [
//             pw.Expanded(flex: 3, child: myTextLabel(label: 'Projet : ', value: item.projet)),
//             pw.Expanded(child: myTextLabel(label: 'Réference : ', value: item.reference))
//           ]),
//           pw.SizedBox(height: height * 2),
//           myTextLabel(label: '1/ Objet de visite : ', value: item.objet),
//           pw.SizedBox(height: height * 2),
//           myTextLabel(label: '2/ Présent lors de la visite : ', value: item.presents),
//           pw.SizedBox(height: height * 2),
//           myTextLabel(label: '3/ Constats effectués : ', value: item.constats),
//           pw.SizedBox(height: height),
//           myTextLabel(label: '    Travaux términés  : ', value: item.travauxFini),
//           pw.SizedBox(height: height),
//           myTextLabel(label: '    Surface achevé : ', value: item.surfaceAcheve),
//           pw.SizedBox(height: height * 2),
//           myTextLabel(label: '4/ Conformité des travaux : ', value: item.conformiteTravaux),
//           pw.SizedBox(height: height),
//           myTextLabel(label: '    Déscription : ', value: item.descrConformiteTravaux),
//           pw.SizedBox(height: height * 2),
//           myTextLabel(label: '5/ Disponibilté des produits : ', value: item.disponibiliteProduits),
//           pw.SizedBox(height: height),
//           myTextLabel(label: '    Type de produit  : ', value: item.typeProduit),
//           pw.SizedBox(height: height),
//           myTextLabel(label: '    Quantité : ', value: item.quantiteProduit),
//           pw.SizedBox(height: height),
//           myTextLabel(label: '    Délai de livraison : ', value: item.delaiLivraison),
//           pw.SizedBox(height: height * 2),
//           myTextLabel(label: '6/ Conformité du stockage des produits : ', value: item.conformiteStockage),
//           pw.SizedBox(height: height),
//           myTextLabel(label: '    Détails : ', value: item.detailsConformiteStockage),
//           pw.SizedBox(height: height * 2),
//           myTextLabel(label: '7/ Réserves signalées : ', value: item.reserveSignale),
//           pw.SizedBox(height: height),
//           myTextLabel(label: '    Détails : ', value: item.detailsReserveSignale),
//           pw.SizedBox(height: height),
//           myTextLabel(label: '8/ Actions correctives : ', value: item.actionCorrective),
//           pw.SizedBox(height: height * 2),
//           myTextLabel(label: 'Prochaine visite : ', value: item.prochaineVisite),
//           pw.SizedBox(height: height),
//           pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
//             pw.Text('Signature',
//                 textAlign: pw.TextAlign.center, style: pw.TextStyle(font: pw.Font.timesBold(), fontSize: 12)),
//             pw.SizedBox(width: 30),
//           ]),
//           pw.SizedBox(height: height * 4),
//         ])),
//   ];
// }
