import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import '../core/class/mydata.dart';
import '../core/class/transport.dart';
import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/sizes.dart';
import '../core/services/httprequest.dart';

class ListTransportsController extends GetxController {
  RxBool loading = false.obs,
      loadingFilter = false.obs,
      filter = false.obs,
      loadingDestination = false.obs,
      loadingExercice = false.obs;
  bool error = false,
      sort = false,
      complete = false,
      sortAscending = true,
      errorExercice = false,
      errorDestination = false;
  List<String> etatTab = [];
  String queryClient = "", queryTransporteurExterne = "";
  String? dropExercice, sortColumn, dropEtat, dropDestination;
  List<DropdownMenuItem> myDropEtatList = [], myDropDestinationList = [], myDropExerciceList = [];
  List<String> exDes = [], destinDes = [];
  int sortIndex = 0, selectIndex = -1;
  late TextEditingController clientController, dateController, dateAuController, transpExterneController;
  List<Transport> allTransports = [], transports = [];
  late MyData myData;

  DropdownMenuItem myDropMenuItem(String label) => DropdownMenuItem(
    value: label,
    child: Center(child: Text(label, textAlign: TextAlign.center)),
  );

  sortBy(String column) {
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
    final transpExterneCol = 'Transp. Externe'.tr;
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

  updateDropExerciceValue(value) {
    dropExercice = value;
    getList(showMessage: true);
  }

  updateDropDestinationValue(value) {
    dropDestination = value;
    getList(showMessage: true);
  }

  updateDropEtatValue(value) {
    dropEtat = value;
    getList(showMessage: true);
  }

  initDropExercice() {
    myDropExerciceList.clear();
    exDes.clear();
    myDropExerciceList.add(myDropMenuItem('Tous'.tr));
    exDes.add('Tous'.tr);

    var now = DateTime.now();
    var formatter = DateFormat('yyyy');
    String year = formatter.format(now);
    dropExercice = year;
  }

  initDropEtat() {
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

  initDropDestination() {
    myDropDestinationList.clear();
    destinDes.clear();
    myDropDestinationList.add(myDropMenuItem('Tous Les Destination'.tr));
    destinDes.add('Tous Les Destination'.tr);

    dropDestination = 'Tous Les Destination'.tr;
  }

  initDate() {
    var now = DateTime.now();
    dateController.text = "${now.year}-${now.month}-${now.day}";
    if (kDebugMode) {
      dateController.text = "2025-05-28";
    }
  }

  onSortColumn(int columnIndex, bool ascending) {
    sortIndex = columnIndex;
    switch (columnIndex) {
      case 2:
        if (sort) {
          transports.sort((a, b) => a.date.compareTo(b.date));
        } else {
          transports.sort((a, b) => b.date.compareTo(a.date));
        }
        break;
      case 4:
        if (sort) {
          transports.sort((a, b) => a.nomClient.compareTo(b.date));
        } else {
          transports.sort((a, b) => b.nomClient.compareTo(a.date));
        }
        break;
      case 6:
        if (sort) {
          transports.sort((a, b) => a.montantProduit.compareTo(b.montantProduit));
        } else {
          transports.sort((a, b) => b.montantProduit.compareTo(a.montantProduit));
        }
        break;
      case 7:
        if (sort) {
          transports.sort((a, b) => a.montantLivrInterne.compareTo(b.montantLivrInterne));
        } else {
          transports.sort((a, b) => b.montantLivrInterne.compareTo(a.montantLivrInterne));
        }
        break;
      case 8:
        if (sort) {
          transports.sort((a, b) => a.montantLivrExterne.compareTo(b.montantLivrExterne));
        } else {
          transports.sort((a, b) => b.montantLivrExterne.compareTo(a.montantLivrExterne));
        }
        break;
      case 9:
        if (sort) {
          transports.sort((a, b) => a.total.compareTo(b.total));
        } else {
          transports.sort((a, b) => b.total.compareTo(a.total));
        }
        break;
      case 10:
        if (sort) {
          transports.sort((a, b) => a.nomTransporteurExterne.compareTo(b.nomTransporteurExterne));
        } else {
          transports.sort((a, b) => b.nomTransporteurExterne.compareTo(a.nomTransporteurExterne));
        }
        break;
      case 13:
        if (sort) {
          transports.sort((a, b) => a.destination.compareTo(b.destination));
        } else {
          transports.sort((a, b) => b.destination.compareTo(a.destination));
        }
        break;
      default:
    }
    sort = !sort;
    myData = MyData();
    update();
  }

  updateBooleans({required newloading, required newerror, required type}) {
    switch (type) {
      case 0:
        loading.value = newloading;
        error = newerror;
        break;
      case 1:
        loadingExercice.value = newloading;
        errorExercice = newerror;
        break;
      case 2:
        loadingDestination.value = newloading;
        errorDestination = newerror;
        break;
      default:
    }
    loadingFilter.value = loadingExercice.value || loadingDestination.value;
    update();
  }

  updateClientQuery(String newValue) {
    queryClient = newValue;
    filtrer();
  }

  updateTransporteurExterneQuery(String newValue) {
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
          if (dropDestination != "Tous".tr && !destinDes.contains(dropDestination)) {
            dropDestination = 'Tous'.tr;
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

  Future getData({
    required String phpFile,
    required String pWhere,
    required int limitStart,
    required int limiEnd,
  }) async {
    try {
      final (response, success) = await httpRequest(
        ftpFile: phpFile,
        json: {"WHERE": pWhere, "LIMIT_START": limitStart.toString(), "LIMIT_END": limiEnd.toString()},
      );
      if (success) {
        if (limitStart == 0) {
          allTransports.clear();
        }
        selectIndex = -1;
        var responsebody = jsonDecode(response!.body);

        for (var m in responsebody) {
          final e = Transport.fromJson(m);
          e.num = allTransports.length + 1;
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

  getWhere() {
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
      int limitStart = 0, limitPas = 50, limiEnd = limitPas;
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
        await getData(phpFile: "GET_TRANSPORTS.php", pWhere: pWhere, limitStart: limitStart, limiEnd: limiEnd);
        while (!complete) {
          await Future.delayed(const Duration(milliseconds: 80));
        }
        limitStart += limitPas;
        limiEnd += limitPas;
        repeat = (nbElt != allTransports.length);
      }

      filtrer(filtering: false);
    }
  }

  deleteProduit(Transport item) async {
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

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
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
    getDropDestination(showMessage: true);
    getDropExercice(showMessage: true);
    getList(showMessage: true);
    super.onInit();
  }

  selectRow(int index) {
    selectIndex = index;
    myData = MyData();
    // AppData.mySnackBar(message: index, color: AppColor.red, title: index);
    update();
  }

  resetSelectedIndex() {
    selectIndex = -1;
    update();
  }

  updatefiltrer() {
    filter.value = !filter.value;
    update();
  }

  @override
  void onClose() {
    clientController.dispose();
    transpExterneController.dispose();
    dateAuController.dispose();
    dateController.dispose();
    super.onClose();
  }

  filtrer({bool filtering = true}) {
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
    myData = MyData();
    if (filtering) {
      update();
    } else {
      updateBooleans(newloading: false, newerror: false, type: 0);
    }
  }

  updateDate(selectDate) {
    dateController.text = selectDate;
    getList(showMessage: true);
  }

  updateDateAu(selectDate) {
    dateAuController.text = selectDate;
    getList(showMessage: true);
  }
}
