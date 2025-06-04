import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'dart:convert';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../core/class/details_transport.dart';
import '../core/class/transport.dart';
import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/image_asset.dart';
import '../core/constant/routes.dart';
import '../core/constant/sizes.dart';
import '../core/impression.dart';
import '../core/localization/change_local.dart';
import '../core/services/httprequest.dart';

class ListTransportsController extends GetxController {
  RxBool loading = false.obs,
      loadingDepot = false.obs,
      loadingFilter = false.obs,
      loadingDetails = false.obs,
      error = false.obs,
      filter = false.obs,
      loadingDestination = false.obs,
      loadingExercice = false.obs;
  ScrollController? verticalController;
  List<DetailsTransport> detailTransport = [];
  final FocusNode tableFocusNode = FocusNode();
  bool sort = false, complete = false, sortAscending = true;
  String queryClient = "", queryTransporteurExterne = "";
  String? dropExercice, sortColumn, dropEtat, dropDestination, dropDepot;
  List<DropdownMenuItem> myDropEtatList = [], myDropDestinationList = [], myDropDepotList = [], myDropExerciceList = [];
  List<String> exDes = [], destinDes = [], depotDes = [], etatTab = [];
  int sortIndex = 0, selectIndex = -1;
  late TextEditingController clientController, dateController, dateAuController, transpExterneController;
  List<Transport> allTransports = [], transports = [];
  Transport? itemSelected;

  DropdownMenuItem myDropMenuItem(String label) => DropdownMenuItem(
    value: label,
    child: Center(child: Text(label, textAlign: TextAlign.center)),
  );

  void sortBy(String column) {
    final nCol = 'N°'.tr;
    final refCol = 'Réf'.tr;
    final dateCol = 'Date'.tr;
    final heureCol = 'Heure'.tr;
    final clientCol = 'Client'.tr;
    final telCol = 'Télephone'.tr;
    final montantProduitCol = 'Montant Produit'.tr;
    final mntLivrInterneCol = 'Mnt Livr Interne'.tr;
    final mntLivrExterneCol = 'Mnt Livr Externe'.tr;
    final totalCol = 'Total'.tr;
    final transpExterneCol = 'Transporteur Externe'.tr;
    final etatCol = 'Etat'.tr;
    final posteCol = 'Poste'.tr;
    final destinationCol = 'Destination'.tr;

    if (sortColumn == column) {
      sortAscending = !sortAscending;
    } else {
      sortColumn = column;
      sortAscending = true;
    }
    transports.sort((a, b) {
      int cmp = 0;
      if (column == nCol) {
        cmp = a.num.compareTo(b.num);
      } else if (column == refCol) {
        cmp = a.exercice.compareTo(b.exercice);
      } else if (column == dateCol) {
        cmp = a.date.compareTo(b.date);
      } else if (column == heureCol) {
        cmp = a.heure.compareTo(b.heure);
      } else if (column == clientCol) {
        cmp = a.nomClient.compareTo(b.nomClient);
      } else if (column == telCol) {
        cmp = a.tel1Client.compareTo(b.tel1Client);
      } else if (column == montantProduitCol) {
        cmp = a.montantProduit.compareTo(b.montantProduit);
      } else if (column == mntLivrInterneCol) {
        cmp = a.montantLivrInterne.compareTo(b.montantLivrInterne);
      } else if (column == mntLivrExterneCol) {
        cmp = a.montantLivrExterne.compareTo(b.montantLivrExterne);
      } else if (column == totalCol) {
        cmp = a.total.compareTo(b.total);
      } else if (column == transpExterneCol) {
        cmp = a.nomTransporteurExterne.compareTo(b.nomTransporteurExterne);
      } else if (column == etatCol) {
        cmp = a.etat.compareTo(b.etat);
      } else if (column == posteCol) {
        cmp = a.poste.compareTo(b.poste);
      } else if (column == destinationCol) {
        cmp = a.destination.compareTo(b.destination);
      }
      return sortAscending ? cmp : -cmp;
    });
    update();
  }

  void updateDropExerciceValue(String? value) {
    dropExercice = value;
    getList(showMessage: true);
  }

  void updateDropDestinationValue(String? value) {
    dropDestination = value;
    getList(showMessage: true);
  }

  void updateDropDepotValue(String? value) {
    dropDepot = value;
    getList(showMessage: true);
  }

  void updateDropEtatValue(String value) {
    dropEtat = value;
    getList(showMessage: true);
  }

  void initDropExercice() {
    myDropExerciceList.clear();
    exDes.clear();
    myDropExerciceList.add(myDropMenuItem('Tous'.tr));
    exDes.add('Tous'.tr);

    var now = DateTime.now();
    var formatter = DateFormat('yyyy');
    String year = formatter.format(now);
    dropExercice = year;
  }

  void initDropEtat() {
    etatTab.clear();
    etatTab.add('Livré Partiellement'.tr);
    etatTab.add('Livré Completement'.tr);
    etatTab.add('En Cours'.tr);
    etatTab.add('Annulé'.tr);
    etatTab.add('Archivé'.tr);

    myDropEtatList.clear();
    myDropEtatList.add(myDropMenuItem('Tous'.tr));
    myDropEtatList.add(myDropMenuItem('Livré Partiellement'.tr));
    myDropEtatList.add(myDropMenuItem('Livré Completement'.tr));
    myDropEtatList.add(myDropMenuItem('En Cours'.tr));
    myDropEtatList.add(myDropMenuItem('Annulé'.tr));
    myDropEtatList.add(myDropMenuItem('Archivé'.tr));
    dropEtat = 'Livré Partiellement'.tr;
  }

  void initDropDestination() {
    myDropDestinationList.clear();
    destinDes.clear();
    myDropDestinationList.add(myDropMenuItem('Tous Les Destination'.tr));
    destinDes.add('Tous Les Destination'.tr);

    dropDestination = 'Tous Les Destination'.tr;
  }

  void initDropDepot() {
    myDropDepotList.clear();
    depotDes.clear();
    myDropDepotList.add(myDropMenuItem('Tous Les Depots'.tr));
    depotDes.add('Tous Les Depots'.tr);

    dropDepot = 'Tous Les Depots'.tr;
  }

  void initDate() {
    var now = DateTime.now();
    dateController.text = "${now.year}-${now.month}-${now.day}";
    if (kDebugMode) {
      dateController.text = "2025-05-11";
    }
  }

  void updateBooleans({required bool newloading, required bool newerror, required int type}) {
    switch (type) {
      case 0:
        loading.value = newloading;
        error.value = newerror;
        break;
      case 1:
        loadingExercice.value = newloading;
        break;
      case 2:
        loadingDestination.value = newloading;
        break;
      case 3:
        loadingDetails.value = newloading;
        break;
      case 4:
        loadingDepot.value = newloading;
        break;
      default:
    }
    loadingFilter.value = loadingExercice.value || loadingDestination.value;
    update();
  }

  void updateClientQuery(String newValue) {
    queryClient = newValue;
    filtrer();
  }

  void updateTransporteurExterneQuery(String newValue) {
    queryTransporteurExterne = newValue;
    filtrer();
  }

  Future getDropExercice({required bool showMessage}) async {
    if (!loadingExercice.value) {
      try {
        updateBooleans(newloading: true, newerror: false, type: 1);
        final (response, success) = await httpRequest(
          ftpFile: 'GET_DROP_EXERCICES.php',
          json: {"TABLE_NAME": "transport"},
        );

        if (success) {
          initDropExercice();
          var responsebody = jsonDecode(response!.body);
          for (var m in responsebody) {
            exDes.add(m['EXERCICE'].toString());
          }
          myDropExerciceList = exDes.map((e) => myDropMenuItem(e)).toList();
          updateBooleans(newloading: false, newerror: false, type: 1);
        } else {
          updateBooleans(newloading: false, newerror: true, type: 1);
          AppData.mySnackBar(
            title: 'Liste des Transports'.tr,
            message: "Probleme de Connexion avec le serveur !!!",
            color: AppColor.red,
          );
        }
      } catch (error) {
        updateBooleans(newloading: false, newerror: true, type: 1);
        debugPrint("erreur getDropExercice: $error");
        AppData.mySnackBar(
          title: 'Liste des Transports'.tr,
          message: "Probleme de Connexion avec le serveur !!!",
          color: AppColor.red,
        );
      }
    }
  }

  Future getDropDestination({required bool showMessage}) async {
    if (!loadingDestination.value) {
      try {
        updateBooleans(newloading: true, newerror: false, type: 2);
        final (response, success) = await httpRequest(ftpFile: 'GET_DROP_DESTINATIONS.php');

        if (success) {
          initDropDestination();
          var responsebody = jsonDecode(response!.body);
          for (var m in responsebody) {
            destinDes.add(m['DESTINATION']);
          }
          myDropDestinationList = destinDes.map((e) => myDropMenuItem(e)).toList();
          if (dropDestination != "Tous Les Destination".tr && !destinDes.contains(dropDestination)) {
            dropDestination = 'Tous Les Destination'.tr;
          }
          updateBooleans(newloading: false, newerror: false, type: 2);
        } else {
          updateBooleans(newloading: false, newerror: true, type: 2);
          AppData.mySnackBar(
            title: 'Liste des Transports'.tr,
            message: "Probleme de Connexion avec le serveur !!!",
            color: AppColor.red,
          );
        }
      } catch (error) {
        updateBooleans(newloading: false, newerror: true, type: 2);
        debugPrint("erreur getDropDestination: $error");
        AppData.mySnackBar(
          title: 'Liste des Transports'.tr,
          message: "Probleme de Connexion avec le serveur !!!",
          color: AppColor.red,
        );
      }
    }
  }

  Future getDropDepot({required bool showMessage}) async {
    if (!loadingDepot.value) {
      try {
        updateBooleans(newloading: true, newerror: false, type: 4);
        final (response, success) = await httpRequest(ftpFile: 'GET_DROP_DEPOT.php');

        if (success) {
          initDropDepot();
          var responsebody = jsonDecode(response!.body);
          for (var m in responsebody) {
            depotDes.add(m['DESIGNATION']);
          }
          myDropDepotList = depotDes.map((e) => myDropMenuItem(e)).toList();
          if (dropDepot != "Tous Les Depots".tr && !depotDes.contains(dropDepot)) {
            dropDepot = 'Tous Les Depots'.tr;
          }
          updateBooleans(newloading: false, newerror: false, type: 4);
        } else {
          updateBooleans(newloading: false, newerror: true, type: 4);
          AppData.mySnackBar(
            title: 'Liste des Transports'.tr,
            message: "Probleme de Connexion avec le serveur !!!",
            color: AppColor.red,
          );
        }
      } catch (error) {
        updateBooleans(newloading: false, newerror: true, type: 4);
        debugPrint("erreur getDropDepot: $error");
        AppData.mySnackBar(
          title: 'Liste des Transports'.tr,
          message: "Probleme de Connexion avec le serveur !!!",
          color: AppColor.red,
        );
      }
    }
  }

  Future getData({
    required String phpFile,
    required String pWhere,
    required int limitStart,
    required int nbLigne,
  }) async {
    try {
      final (response, success) = await httpRequest(
        ftpFile: phpFile,
        json: {"WHERE": pWhere, "LIMIT_START": limitStart.toString(), "NB_LIGNE": nbLigne.toString()},
      );
      if (success) {
        if (limitStart == 0) {
          allTransports.clear();
        }
        selectIndex = -1;
        var responsebody = jsonDecode(response!.body);

        for (var m in responsebody) {
          final e = Transport.fromJson(m);
          allTransports.add(e);
        }

        complete = true;
      } else {
        updateBooleans(newloading: false, newerror: true, type: 0);
        complete = true;
        AppData.mySnackBar(
          title: 'Liste des Transports'.tr,
          message: "Probleme de Connexion avec le serveur !!!",
          color: AppColor.red,
        );
      }
    } catch (error) {
      debugPrint("erreur getData: $error");
      updateBooleans(newloading: false, newerror: true, type: 0);
      complete = true;
      AppData.mySnackBar(
        title: 'Liste des Transports'.tr,
        message: "Probleme de Connexion avec le serveur !!!",
        color: AppColor.red,
      );
    }
  }

  String getWhere() {
    String pWhere = "";
    if (dropExercice != "Tous".tr) {
      pWhere += " AND E.EXERCICE = $dropExercice";
    }
    if (dropDestination != "Tous Les Destination".tr) {
      pWhere += " AND IFNULL(CONCAT(D.VILLE_DEPART,' -> ',D.VILLE_ARRIVEE),'') = '$dropDestination'";
    }
    if (dateController.text.isNotEmpty || dateAuController.text.isNotEmpty) {
      if (dateAuController.text.isNotEmpty && dateAuController.text.isNotEmpty) {
        pWhere += " AND E.DATE_TRANSPORT BETWEEN '${dateController.text}' AND '${dateAuController.text}'";
      } else {
        pWhere +=
            " AND E.DATE_TRANSPORT = '${dateController.text.isNotEmpty ? dateController.text : dateAuController.text}'";
      }
    }
    if (dropEtat != 'Tous'.tr) {
      switch (etatTab.indexOf(dropEtat!)) {
        case 0:
          pWhere += " AND E.ETAT < 3 ";
          break;
        case 1:
          pWhere += " AND E.ETAT = 4";
          break;
        case 2:
          pWhere += " AND E.ETAT = 1";
          break;
        case 3:
          pWhere += " AND E.ETAT = 3";
          break;
        case 4:
          pWhere += " AND E.ETAT = 5";
          break;
        default:
      }
    }
    return pWhere;
  }

  Future getList({required bool showMessage}) async {
    if (!loading.value) {
      updateBooleans(newloading: true, newerror: false, type: 0);
      int limitStart = 0, limitPas = 100;
      String pWhere = getWhere();
      bool repeat = true;
      int nbElt = 0, cp = 0;
      while (repeat && loading.value) {
        repeat = false;
        cp++;
        if (cp != 1) {
          nbElt = allTransports.length;
        }
        complete = false;
        await getData(phpFile: "GET_TRANSPORTS.php", pWhere: pWhere, limitStart: limitStart, nbLigne: limitPas);
        while (!complete) {
          await Future.delayed(const Duration(milliseconds: 80));
        }
        limitStart += limitPas;
        repeat = (nbElt != allTransports.length);
      }

      filtrer(filtering: false);
    }
  }

  Future<void> deleteProduit(Transport item) async {
    // String serverDir = AppData.getServerDirectory();
    // var url = "$serverDir/DELETE_PRODUIT.php";
    // debugPrint(url);
    // Uri myUri = Uri.parse(url);
    // http
    //     .post(myUri, body: {
    //       "BDD": AppData.dossier,
    //       "ID_PRODUIT": item.idProduit.toString()
    //     })
    //     .timeout(AppData.getTimeOut())
    //     .then((response) async {
    //       if (response.statusCode == 200) {
    //         var result = response.body;
    //         if (result != "0") {
    //           getProduits(showMessage: false);
    //           Get.back();
    //           AppData.mySnackBar(
    //               title: 'Liste des produits',
    //               message: "Produit supprimé ...",
    //               color: AppColor.green);
    //         } else {
    //           AppData.mySnackBar(
    //               title: 'Liste des produits',
    //               message: "Probleme lors de la suppression !!!",
    //               color: AppColor.red);
    //         }
    //       } else {
    //         AppData.mySnackBar(
    //             title: 'Liste des produits',
    //             message: "Probleme de Connexion avec le serveur !!!",
    //             color: AppColor.red);
    //       }
    //     })
    //     .catchError((error) {
    //       debugPrint("erreur deleteProduit: $error");
    //       AppData.mySnackBar(
    //           title: 'Liste des produits',
    //           message: "Probleme de Connexion avec le serveur !!!",
    //           color: AppColor.red);
    //     });
  }

  Future getDetails({required Transport item, bool priniting = false}) async {
    if (!loadingDetails.value) {
      updateBooleans(newloading: true, newerror: false, type: 3);
      try {
        detailTransport.clear();
        final (response, success) = await httpRequest(
          ftpFile: "GET_DETAILS_TRANSPORTS.php",
          json: {"ID_TRANSPORT": item.idTransport.toString(), "EXERCICE": item.exercice.toString()},
        );
        if (success) {
          var responsebody = jsonDecode(response!.body);
          for (var m in responsebody) {
            final e = DetailsTransport.fromJson(m);
            detailTransport.add(e);
          }
          updateBooleans(newloading: false, newerror: false, type: 3);

          if (priniting) {
            printBonTransport(item);
          }
        } else {
          Get.back();
          updateBooleans(newloading: false, newerror: true, type: 3);
          AppData.mySnackBar(
            title: 'Liste des Transports'.tr,
            message: "Probleme de Connexion avec le serveur !!!",
            color: AppColor.red,
          );
        }
      } catch (error) {
        debugPrint("erreur getDetails: $error");
        updateBooleans(newloading: false, newerror: true, type: 3);
        Get.back();
        AppData.mySnackBar(
          title: 'Liste des Transports'.tr,
          message: "Probleme de Connexion avec le serveur !!!",
          color: AppColor.red,
        );
      }
    }
  }

  Future<int?> showCopyNumberDialog() async {
    final TextEditingController controller = TextEditingController(text: "1");
    final FocusNode textFocusNode = FocusNode();
    return showDialog<int>(
      context: Get.context!,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            textFocusNode.requestFocus();
            controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length);
          });
          return Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{LogicalKeySet(LogicalKeyboardKey.escape): const ActivateIntent()},
            child: Actions(
              actions: <Type, Action<Intent>>{
                ActivateIntent: CallbackAction<Intent>(
                  onInvoke: (Intent intent) {
                    Navigator.of(context).pop();
                    return null;
                  },
                ),
              },
              child: AlertDialog(
                title: Text("Nombre de copies".tr),
                content: TextField(
                  controller: controller,
                  focusNode: textFocusNode,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Entrez le nombre de copies".tr),
                  onSubmitted: (value) {
                    final intValue = int.tryParse(value);
                    Navigator.of(context).pop(intValue);
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(), // Cancel
                    child: Text("Annuler".tr),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final value = int.tryParse(controller.text);
                      Navigator.of(context).pop(value);
                    },
                    child: Text("Valider".tr),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context!);
    clientController = TextEditingController();
    transpExterneController = TextEditingController();
    dateAuController = TextEditingController();
    dateController = TextEditingController();
    queryClient = "";
    queryTransporteurExterne = "";
    initDate();
    initDropExercice();
    initDropEtat();
    initDropDestination();
    initDropDepot();
    getDropDestination(showMessage: true);
    getDropExercice(showMessage: true);
    getDropDepot(showMessage: true);
    getList(showMessage: true);
    super.onInit();
  }

  void selectRow(int index) {
    selectIndex = index;
    itemSelected = transports[index];
    update();
  }

  void resetSelectedIndex() {
    selectIndex = -1;
    update();
  }

  void updatefiltrer() {
    filter.value = !filter.value;
    update();
  }

  @override
  void onClose() {
    clientController.dispose();
    transpExterneController.dispose();
    dateAuController.dispose();
    dateController.dispose();
    tableFocusNode.dispose();
    super.onClose();
  }

  void filtrer({bool filtering = true}) {
    transports.clear();
    if (queryClient.removeAllWhitespace.isEmpty && queryTransporteurExterne.removeAllWhitespace.isEmpty) {
      transports.addAll(allTransports);
    } else {
      for (var item in allTransports) {
        if (queryClient.removeAllWhitespace.isNotEmpty && queryTransporteurExterne.removeAllWhitespace.isNotEmpty) {
          if (item.nomClient.toUpperCase().contains(queryClient.toUpperCase()) &&
              item.nomTransporteurExterne.toUpperCase().contains(queryTransporteurExterne.toUpperCase())) {
            transports.add(item);
          }
        } else if (queryClient.removeAllWhitespace.isNotEmpty) {
          if (item.nomClient.toUpperCase().contains(queryClient.toUpperCase())) {
            transports.add(item);
          }
        } else {
          if (item.nomTransporteurExterne.toUpperCase().contains(queryTransporteurExterne.toUpperCase())) {
            transports.add(item);
          }
        }
      }
    }

    for (int i = 0; i < transports.length; i++) {
      transports[i].num = transports.length - i;
    }

    if (filtering) {
      update();
    } else {
      updateBooleans(newloading: false, newerror: false, type: 0);
    }
  }

  void updateDate(String selectDate) {
    dateController.text = selectDate;
    getList(showMessage: true);
  }

  void updateDateAu(String selectDate) {
    dateAuController.text = selectDate;
    getList(showMessage: true);
  }

  List<List<String>> getTablePrint(int id, exercice) {
    List<DetailsTransport> vDetails = detailTransport
        .where((item) => item.idTransport == id && item.exercice == exercice)
        .toList();
    List<List<String>> data = [];
    for (var item in vDetails) {
      List<String> row = [];
      row.add(item.nomFournisseur);
      row.add(AppData.formatMoney(item.qte));
      row.add(AppData.formatMoney(item.montantTransExterne));
      row.add(AppData.formatMoney(item.montantProduit));
      data.add(row);
    }
    return data;
  }

  void printBonTransport(Transport item) async {
    await showCopyNumberDialog().then((nb) async {
      if (nb == null) return;
      if (nb <= 0) return;
      final doc = pw.Document();
      const double inch = 72.0;
      final theme = pw.ThemeData.withFont(
        base: pw.Font.ttf(await rootBundle.load('assets/fonts/Tajawal-Regular.ttf')),
        bold: pw.Font.ttf(await rootBundle.load('assets/fonts/Tajawal-Bold.ttf')),
      );
      final phoneIconData = await rootBundle.load(AppImageAsset.phone);
      final phoneIcon = pw.MemoryImage(phoneIconData.buffer.asUint8List());
      List<List<String>> data = getTablePrint(item.idTransport, item.exercice);
      LocaleController langController = Get.find();
      PdfPageFormat pageFormat = PdfPageFormat(8.5 * inch, 11.0 * inch, marginAll: inch);
      for (int i = 0; i < nb; i++) {
        doc.addPage(
          pw.MultiPage(
            textDirection: langController.language == Locale('ar') ? pw.TextDirection.rtl : pw.TextDirection.ltr,
            maxPages: 100000,
            pageFormat: pageFormat,
            theme: theme,
            margin: pw.EdgeInsets.all(14),
            build: (context) => getBonTransport(item, data, context, phoneIcon),
          ),
        );
      }

      if (kDebugMode) {
        Get.toNamed(
          AppRoute.impression,
          arguments: {'DOC': doc, 'TITLE': 'List_Transports'.tr, 'PAGE_FORMAT': pageFormat},
        );
      } else {
        await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());
      }
    });
  }
}
