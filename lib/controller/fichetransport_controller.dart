import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/sizes.dart';
import '../core/services/httprequest.dart';

class FicheTransportController extends GetxController {
  RxBool loading = false.obs,
      loadingFilter = false.obs,
      loadingDetails = false.obs,
      error = false.obs,
      filter = false.obs,
      errorExercice = false.obs,
      errorDestination = false.obs,
      loadingDestination = false.obs,
      loadingExercice = false.obs;
  late int idTransport, exercice, idClient, idTransporteur, idDestination;
  // Donnee? depotDefault;
  late FocusNode focusNumFa, focusClient, focusDestination;
  late String title, tableName, tableNameFrom;
  String? dropOrganisme;
  List<DropdownMenuItem> myDropList = [];
  double tva = 0, tvap = 0, timbre = 0, ttc = 0, ht = 0;
  List<DropdownMenuItem> myDropEtatList = [], myDropDestinationList = [], myDropExerciceList = [];
  List<String> exDes = [], destinDes = [], etatTab = [];
  String? dropExercice, sortColumn, dropEtat, dropDestination;
  bool valClient = false,
      valDestination = false,
      loadingMagasin = false,
      loadingDepot = false,
      valNum = false,
      errorDepot = false,
      errorMagasin = false,
      existPrix = true,
      valCheckSansFacture = false,
      valCheckTva = false,
      valCheckNumAuto = false,
      valCheckTimbre = false,
      valider = false,
      errorDetails = false;
  // List<ProduitFacture> produits = [];
  late TextEditingController txtDate,
      txtDateOld,
      txtTime,
      txtClient,
      txtDestination,
      txtTransporteur,
      txtNum,
      txtHT,
      txtTimbre,
      txtTva,
      txtPrixCondition,
      txtDelaiLivraison,
      txtGarantie,
      txtModePaiement,
      txtInfoSupp,
      txtTvaPourc,
      txtBasPage,
      txtObjet,
      txtTTC;

  FicheTransportController({required int id, required int ex}) {
    idTransport = id;
    exercice = ex;
  }

  void updateDropDestinationValue(String? value) {
    dropDestination = value;
    update();
  }

  DropdownMenuItem myDropMenuItem(String label) => DropdownMenuItem(
    value: label,
    child: Center(child: Text(label, textAlign: TextAlign.center)),
  );

  // Future getDepots({required bool showMessage}) async {
  //   if (loadingDepot) return;
  //   nbDepot = 0;
  //   depotDefault = null;
  //   updateDepotBooleans(newloading: true, newerror: false);
  //   try {
  //     final (response, success) = await httpRequest(ftpFile: 'GET_DEPOT.php');
  //     if (success) {
  //       var responsebody = jsonDecode(response!.body);
  //       nbDepot = responsebody.length;
  //       if (nbDepot == 1) {
  //         for (var m in responsebody) {
  //           depotDefault = Donnee(id: AppData.getInt(m, 'ID'), designation: m['DESIGNATION'], canDelete: false);
  //         }
  //       }
  //       updateDepotBooleans(newloading: false, newerror: false);
  //     } else {
  //       Get.back();
  //       AppData.mySnackBar(title: title, message: "Probleme de Connexion avec le serveur !!!", color: AppColor.red);
  //       updateDepotBooleans(newloading: false, newerror: true);
  //     }
  //   } catch (error) {
  //     debugPrint("erreur getDepots: $error");
  //     Get.back();
  //     AppData.mySnackBar(title: title, message: "Probleme de Connexion avec le serveur !!!", color: AppColor.red);
  //     updateDepotBooleans(newloading: false, newerror: true);
  //   }
  // }

  // produitExist(ProduitFacture pf) =>
  //     produits.any((item) => pf.idProduit == item.idProduit && pf.idDepot == item.idDepot);

  // updateCheckTva(value) {
  //   valCheckTva = value;
  //   tvap = value ? 0.19 : 0;
  //   txtTvaPourc.text = (tvap * 100).toStringAsFixed(2);
  //   if (!valCheckTva) {
  //     updateCheckTimbre(false);
  //   } else {
  //     updateTotal();
  //   }
  // }

  // updateCheckNumAuto(value) {
  //   valCheckNumAuto = value;
  //   update();
  // }

  // updateCheckSansFacture(value) {
  //   valCheckSansFacture = value;
  //   update();
  // }

  // updateCheckTimbre(value) {
  //   valCheckTimbre = value;
  //   updateTotal();
  // }

  // updateTvapP(String value) {
  //   tvap = double.parse(value) / 100;
  //   updateTotal();
  // }

  // updateHT() {
  //   ht = produits.fold(0, (sum, item) => sum + ((type < 3) || (type == 7) ? item.totalAchat : item.totalVente));
  //   txtHT.text = AppData.formatMoney(ht);
  //   updateTotal();
  // }

  // updateTotal() {
  //   tva = valCheckTva ? ht * tvap : 0;
  //   ttc = ht + tva;
  //   timbre = valCheckTimbre ? ttc * 0.01 : 0;
  //   ttc += timbre;

  //   txtTTC.text = AppData.formatMoney(ttc);
  //   txtTimbre.text = AppData.formatMoney(timbre);
  //   txtTva.text = AppData.formatMoney(tva);
  //   update();
  // }

  void updateDate(String value) {
    String year = value.substring(0, 4);

    if (idTransport == 0) {
      txtDate.text = value;
      exercice = int.parse(year);
    } else {
      if (year != exercice.toString()) {
        AppData.mySnackBar(
          title: title,
          message: 'Date incorrecte !!! \n Veuillez choisir une date dans le meme exercice !!!!',
          color: AppColor.red,
        );
      } else {
        txtDate.text = value;
      }
    }
    update();
  }

  void updateTime(String value) {
    txtTime.text = value;
    update();
  }

  void updateBooleansDestination({required bool newloading, required bool newerror}) {
    loadingDestination.value = newloading;
    errorDestination.value = newerror;
    update();
  }

  Future getDropDestination({required bool showMessage}) async {
    if (!loadingDestination.value) {
      try {
        updateBooleansDestination(newloading: true, newerror: false);
        final (response, success) = await httpRequest(ftpFile: 'GET_DROP_DESTINATIONS.php');

        if (success) {
          initDropDestination();
          var responsebody = jsonDecode(response!.body);
          for (var m in responsebody) {
            destinDes.add(m['DESTINATION']);
          }
          myDropDestinationList = destinDes.map((e) => myDropMenuItem(e)).toList();
          if (dropDestination != "" && !destinDes.contains(dropDestination)) {
            dropDestination = '';
          }
          updateBooleansDestination(newloading: false, newerror: false);
        } else {
          updateBooleansDestination(newloading: false, newerror: true);
          AppData.mySnackBar(
            title: 'Liste des Transports'.tr,
            message: "Probleme de Connexion avec le serveur !!!",
            color: AppColor.red,
          );
        }
      } catch (error) {
        updateBooleansDestination(newloading: false, newerror: true);
        debugPrint("erreur getDropDestination: $error");
        AppData.mySnackBar(
          title: 'Liste des Transports'.tr,
          message: "Probleme de Connexion avec le serveur !!!",
          color: AppColor.red,
        );
      }
    }
  }

  // updateValider({required bool newValue}) {
  //   valider = newValue;
  //   update();
  // }

  // updateLoading({newloading, newerror}) {
  //   loading = newloading;
  //   error = newerror;
  //   update();
  // }

  // updateLoadingDetails({newloading, newerror}) {
  //   loadingDetails = newloading;
  //   errorDetails = newerror;
  //   update();
  // }

  void updateClientValue({required int pIdClient, required String pNomClient}) {
    txtClient.text = pNomClient;
    idClient = pIdClient;
    update();
  }

  void updateDestinationValue({required int pIdDestination, required String pNomDestination}) {
    txtDestination.text = pNomDestination;
    idDestination = pIdDestination;
    update();
  }

  // updateMagasinValue({required int pIdMagsin, required String pNomMagsin}) {
  //   txtMagasin.text = pNomMagsin;
  //   idMagasin = pIdMagsin;
  //   update();
  // }

  // updateTransporteurValue({required int pIdTransporteur, required String pNomTransporteur}) {
  //   txtTransporteur.text = pNomTransporteur;
  //   idTransporteur = pIdTransporteur;
  //   update();
  // }

  Future<bool> onWillPop() async =>
      (await showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.cancel_outlined, color: AppColor.red),
              const Padding(padding: EdgeInsets.only(left: 8.0), child: Text('Annuler ?')),
            ],
          ),
          content: const Text("Voulez-vous vraiment annuler tous les changements !!!"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Get.back(result: false),
              child: Text('Non', style: TextStyle(color: AppColor.red)),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: Text('Oui', style: TextStyle(color: AppColor.green)),
            ),
          ],
        ),
      )) ??
      false;

  // saveFacture() {
  //   updateValider(newValue: true);
  //   valMagasin = (idMagasin == 0 || txtMagasin.text.removeAllWhitespace.isEmpty);
  //   valClient = (idClient == 0 || txtClient.text.removeAllWhitespace.isEmpty);
  //   valNum = (type == 2 || type == 4 || type == 6) && (txtNum.text.removeAllWhitespace.isEmpty) && !valCheckNumAuto;
  //   if (valClient || valMagasin || valNum) {
  //     String msg = valClient && valMagasin
  //         ? 'Veuillez remplir les champs obligatoire !!!'
  //         : valMagasin
  //         ? "Veuillez choisir un magasin !!!!"
  //         : valClient
  //         ? "Veuillez choisir un ${(type < 3) || (type == 7) ? 'Fournisseur' : 'Client'} !!!!"
  //         : 'Veuillez saisir le numero !!!!';
  //     if (kDebugMode) {
  //       debugPrint(msg);
  //     }
  //     updateValider(newValue: false);
  //     AppData.mySnackBar(color: AppColor.red, title: title, message: msg);
  //     if (valNum) {
  //       focusNumFa.requestFocus();
  //     } else {
  //       focusClient.requestFocus();
  //     }
  //   } else {
  //     if (produits.isEmpty) {
  //       debugPrint("Liste de produits vide !!!!");
  //       updateValider(newValue: false);
  //       AppData.mySnackBar(color: AppColor.red, title: title, message: "Table de produits vide !!!!");
  //     } else {
  //       if (type == 6 && valCheckNumAuto) {
  //         txtNum.text = "";
  //       }
  //       idFacture == 0 ? insertFacture() : updateFacture();
  //     }
  //   }
  // }

  // getJsonProduits() {
  //   const JsonEncoder encoder = JsonEncoder();
  //   List<Map<String, String>> data = produits.map((item) {
  //     return {
  //       "ID_PRODUIT": item.idProduit.toString(),
  //       "ID_DEPOT": item.idDepot.toString(),
  //       "ID_UNITE": item.idUnite.toString(),
  //       "DES_PRODUIT": item.desProduit,
  //       "REF": item.ref,
  //       "OBS": item.obs,
  //       "TYPE": item.isService ? '2' : '1',
  //       "QTE": item.qte.toString(),
  //       "PRIX_VENTE": item.prixVente.toString(),
  //       "PRIX_ACHAT": item.prixAchat.toString(),
  //       "TOTAL_ACHAT": item.totalAchat.toString(),
  //       "TOTAL_VENTE": item.totalVente.toString(),
  //     };
  //   }).toList();
  //   return encoder.convert(data);
  // }

  // insertFacture() async {
  //   final String jsonProduits = getJsonProduits();
  //   try {
  //     final (response, success) = await httpRequest(
  //       ftpFile: 'INSERT_${tableName.toUpperCase()}.php',
  //       json: {
  //         "DATE": txtDate.text,
  //         "ID_PERSON": idClient.toString(),
  //         "EXERCICE": exercice.toString(),
  //         "HEURE": txtTime.text,
  //         "HT": ht.toString(),
  //         "TTC": ttc.toString(),
  //         "INT_TIMBRE": valCheckTimbre ? '1' : '0',
  //         "TIMBRE": timbre.toString(),
  //         "INT_FACTURE": valCheckSansFacture ? '1' : '0',
  //         "ID_TRANSPORTEUR": idTransporteur.toString(),
  //         "POURC_TVA": tvap.toString(),
  //         "TVA": tva.toString(),
  //         "BAS_PAGE": txtBasPage.text,
  //         "ID_MAGASIN": idMagasin.toString(),
  //         "CONDITION": txtPrixCondition.text,
  //         "DELAI_LIVRAISON": txtDelaiLivraison.text,
  //         "MODE_PAIEMENT": txtModePaiement.text,
  //         "GARANTIE": txtGarantie.text,
  //         "OBJET": txtObjet.text,
  //         "OBS": txtInfoSupp.text,
  //         "NUM": txtNum.text,
  //         "ORGANISME": typeOrganisme.toString(),
  //         "PRODUITS": jsonProduits,
  //       },
  //     );
  //     if (success) {
  //       var responsebody = response!.body;
  //       if (kDebugMode) {
  //         debugPrint("$title Response=$responsebody");
  //       }
  //       if (responsebody != "0") {
  //         updateValider(newValue: true);
  //         Get.back(result: "success");
  //       } else {
  //         updateValider(newValue: false);
  //         AppData.mySnackBar(title: title, message: "Probleme lors de l'ajout !!!", color: AppColor.red);
  //       }
  //     } else {
  //       updateValider(newValue: false);
  //       AppData.mySnackBar(title: title, message: "Probleme de Connexion avec le serveur !!!", color: AppColor.red);
  //     }
  //   } catch (error) {
  //     debugPrint("erreur insert $title: $error");
  //     updateValider(newValue: false);
  //     AppData.mySnackBar(title: title, message: "Probleme de Connexion avec le serveur !!!", color: AppColor.red);
  //   }
  // }

  // updateFacture() async {
  //   final String jsonProduits = getJsonProduits();
  //   try {
  //     final (response, success) = await httpRequest(
  //       ftpFile: 'UPDATE_${tableName.toUpperCase()}.php',
  //       json: {
  //         "ID_${tableName.toUpperCase()}": idFacture.toString(),
  //         "DATE": txtDate.text,
  //         "ID_PERSON": idClient.toString(),
  //         "EXERCICE": exercice.toString(),
  //         "HEURE": txtTime.text,
  //         "HT": ht.toString(),
  //         "TTC": ttc.toString(),
  //         "INT_TIMBRE": valCheckTimbre ? '1' : '0',
  //         "TIMBRE": timbre.toString(),
  //         "INT_FACTURE": valCheckSansFacture ? '1' : '0',
  //         "ID_TRANSPORTEUR": idTransporteur.toString(),
  //         "POURC_TVA": tvap.toString(),
  //         "TVA": tva.toString(),
  //         "BAS_PAGE": txtBasPage.text,
  //         "ID_MAGASIN": idMagasin.toString(),
  //         "CONDITION": txtPrixCondition.text,
  //         "DELAI_LIVRAISON": txtDelaiLivraison.text,
  //         "MODE_PAIEMENT": txtModePaiement.text,
  //         "GARANTIE": txtGarantie.text,
  //         "OBS": txtInfoSupp.text,
  //         "OBJET": txtObjet.text,
  //         "NUM": txtNum.text,
  //         "ORGANISME": typeOrganisme.toString(),
  //         "PRODUITS": jsonProduits,
  //       },
  //     );
  //     if (success) {
  //       var responsebody = response!.body;
  //       if (kDebugMode) {
  //         debugPrint("$title Response=$responsebody");
  //       }
  //       if (responsebody != "0") {
  //         updateValider(newValue: true);
  //         Get.back(result: "success");
  //       } else {
  //         updateValider(newValue: false);
  //         AppData.mySnackBar(
  //           title: title,
  //           message: "Probleme lors de la mise a jour des informations !!!",
  //           color: AppColor.red,
  //         );
  //       }
  //     } else {
  //       updateValider(newValue: false);
  //       AppData.mySnackBar(title: title, message: "Probleme de Connexion avec le serveur !!!", color: AppColor.red);
  //     }
  //   } catch (error) {
  //     debugPrint("erreur update $title: $error");
  //     updateValider(newValue: false);
  //     AppData.mySnackBar(title: title, message: "Probleme de Connexion avec le serveur !!!", color: AppColor.red);
  //   }
  // }

  // getFactureInfo({bool transfert = false}) async {
  //   updateLoading(newloading: true, newerror: false);
  //   try {
  //     final (response, success) = await httpRequest(
  //       ftpFile: 'GET_INFO_${transfert ? tableNameFrom.toUpperCase() : tableName.toUpperCase()}.php',
  //       json: {
  //         "ID": transfert ? idFrom.toString() : idFacture.toString(),
  //         "EXERCICE": transfert ? exFrom.toString() : exercice.toString(),
  //       },
  //     );
  //     if (success) {
  //       var responsebody = jsonDecode(response!.body);
  //       for (var m in responsebody) {
  //         txtClient.text = m['NOM_CLIENT'];
  //         txtTransporteur.text = ((transfert ? typefrom : type) == 5) ? m['NOM_TRANSPORTEUR'] : '';
  //         txtMagasin.text = m['DES_MAGASIN'];
  //         if (!transfert) txtDate.text = m['DATE'];
  //         txtHT.text = m['HT'].toString();
  //         ht = AppData.getDouble(m, 'HT');
  //         txtTTC.text = m['TTC'].toString();
  //         ttc = AppData.getDouble(m, 'TTC');
  //         txtTimbre.text = m['TIMBRE'].toString();
  //         timbre = AppData.getDouble(m, 'TIMBRE');
  //         txtNum.text =
  //             ((transfert ? typefrom : type) == 2 ||
  //                 (transfert ? typefrom : type) == 4 ||
  //                 (transfert ? typefrom : type) == 6)
  //             ? m['NUM']
  //             : '';
  //         valCheckNumAuto = txtNum.text.removeAllWhitespace.isEmpty;
  //         txtInfoSupp.text = ((transfert ? typefrom : type) == 6) ? m['OBS'] : '';
  //         txtBasPage.text = ((transfert ? typefrom : type) != 6) ? m['BAS_PAGE'] : '';
  //         txtGarantie.text = ((transfert ? typefrom : type) == 3) ? m['GARANTIE'] : '';
  //         txtDelaiLivraison.text = ((transfert ? typefrom : type) == 3) ? m['DELAI_LIVRAISON'] : '';
  //         txtModePaiement.text = ((transfert ? typefrom : type) == 3) ? m['MODE_PAIEMENT'] : '';
  //         txtPrixCondition.text = ((transfert ? typefrom : type) == 3) ? m['DELAI_PRIX'] : '';
  //         txtObjet.text = ((transfert ? typefrom : type) == 3) ? m['OBJET'] : '';
  //         if (!transfert) txtTime.text = m['HEURE'];
  //         txtTva.text = m['TVA'].toString();
  //         tva = AppData.getDouble(m, 'TVA');
  //         txtTvaPourc.text = m['TVA_P'].toString();
  //         tvap = AppData.getDouble(m, 'TVA_P');
  //         idClient = AppData.getInt(m, 'ID_CLIENT');
  //         idMagasin = AppData.getInt(m, 'ID_MAGASIN');
  //         valCheckSansFacture = ((transfert ? typefrom : type) == 5) ? AppData.getInt(m, 'SANS_FACTURE') == 1 : false;
  //         idTransporteur = ((transfert ? typefrom : type) == 5) ? AppData.getInt(m, 'ID_TRANSPORTEUR') : 0;
  //         valNum = (AppData.getInt(m, 'INT_TIMBRE') == 1);
  //         valCheckTva = (AppData.getDouble(m, 'TVA') != 0);
  //       }
  //       updateLoading(newloading: false, newerror: false);
  //     } else {
  //       updateLoading(newloading: false, newerror: true);
  //       Get.back();
  //       AppData.mySnackBar(title: title, message: "Probleme de Connexion avec le serveur !!!", color: AppColor.red);
  //     }
  //   } catch (error) {
  //     updateLoading(newloading: false, newerror: true);
  //     debugPrint("erreur get$title Info: $error");
  //     Get.back();
  //     AppData.mySnackBar(title: title, message: "Probleme de Connexion avec le serveur !!!", color: AppColor.red);
  //   }
  // }

  // getFactureDetailsInfo({bool transfert = false}) async {
  //   updateLoadingDetails(newloading: true, newerror: false);
  //   try {
  //     final (response, success) = await httpRequest(
  //       ftpFile: 'GET_INFO_DETAILS_${transfert ? tableNameFrom.toUpperCase() : tableName.toUpperCase()}.php',
  //       json: {
  //         "ID": transfert ? idFrom.toString() : idFacture.toString(),
  //         "EXERCICE": transfert ? exFrom.toString() : exercice.toString(),
  //       },
  //     );
  //     if (success) {
  //       produits = [];
  //       ProduitFacture pf;
  //       double totalAchat, prixAchat, prixVente, totalVente, qte;
  //       var responsebody = jsonDecode(response!.body);
  //       bool isAchat = (transfert ? typefrom : type) < 3 || (transfert ? typefrom : type) == 7;
  //       for (var m in responsebody) {
  //         qte = AppData.getDouble(m, 'QT');
  //         prixAchat = isAchat ? AppData.getDouble(m, 'PRIX_ACHAT') : 0;
  //         prixVente = isAchat ? 0 : AppData.getDouble(m, 'PRIX_VENTE');
  //         totalAchat = prixAchat * qte;
  //         totalVente = prixVente * qte;

  //         pf = ProduitFacture(
  //           totalAchat: totalAchat,
  //           totalVente: totalVente,
  //           desMarque: m['DES_MARQUE'],
  //           desCouleur: m['DES_COULEUR'],
  //           desFamille: m['DES_FAMILLE'],
  //           desProduit: m['DES_PRODUIT'],
  //           desDepot: m['DES_DEPOT'],
  //           isService: AppData.getInt(m, 'TYPE_PRODUIT') == 2,
  //           idDepot: AppData.getInt(m, 'ID_DEPOT'),
  //           idUnite: AppData.getInt(m, 'ID_UNITE'),
  //           qteStock: AppData.getDouble(m, 'QTE_DISP'),
  //           desUnite: m['DES_UNITE'],
  //           idProduit: m['ID_PRODUIT'],
  //           ref: m['REF'],
  //           qte: qte,
  //           oldQte: qte,
  //           obs: m['OBS'],
  //           prixVente: prixVente,
  //           prixAchat: prixAchat,
  //         );
  //         produits.add(pf);
  //       }
  //       updateLoadingDetails(newloading: false, newerror: false);
  //     } else {
  //       updateLoadingDetails(newloading: false, newerror: true);
  //       Get.back();
  //     }
  //   } catch (error) {
  //     updateLoadingDetails(newloading: false, newerror: true);
  //     debugPrint("erreur get${title}_details Info: $error");
  //     Get.back();
  //   }
  // }

  void initDropDestination() {
    myDropDestinationList.clear();
    destinDes.clear();
    myDropDestinationList.add(myDropMenuItem(''));
    destinDes.add('');

    dropDestination = '';
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    init();
    super.onInit();
  }

  void init() {
    AppSizes.setSizeScreen(Get.context!);
    // produits = [];
    tva = 0;
    focusNumFa = FocusNode();
    focusClient = FocusNode();
    focusDestination = FocusNode();
    valCheckSansFacture = false;
    valCheckTimbre = false;
    valCheckTva = false;
    tvap = 0;
    timbre = 0;
    idDestination = 0;
    ttc = 0;
    idClient = 0;
    idTransporteur = 0;
    ht = 0;
    initDropDestination();
    getDropDestination(showMessage: true);
    txtDateOld = TextEditingController(text: DateTime.now().toString().substring(0, 10));
    txtDate = TextEditingController(text: DateTime.now().toString().substring(0, 10));
    txtTime = TextEditingController(text: TimeOfDay.now().format(Get.context!));
    txtHT = TextEditingController(text: AppData.formatMoney(ht));
    txtTTC = TextEditingController(text: AppData.formatMoney(ttc));
    txtTimbre = TextEditingController(text: AppData.formatMoney(timbre));
    txtTva = TextEditingController(text: AppData.formatMoney(tva));
    txtDestination = TextEditingController(text: '');
    txtModePaiement = TextEditingController(text: '');
    txtGarantie = TextEditingController(text: '');
    txtDelaiLivraison = TextEditingController(text: '');
    txtPrixCondition = TextEditingController(text: '');
    txtTransporteur = TextEditingController(text: '');
    txtObjet = TextEditingController(text: '');
    txtBasPage = TextEditingController(text: '');
    txtClient = TextEditingController(text: '');
    txtInfoSupp = TextEditingController(text: '');
    txtNum = TextEditingController(text: '');
    txtTvaPourc = TextEditingController(text: AppData.formatMoney(tvap));

    // getMagasins(showMessage: true);
    // getDepots(showMessage: true);

    // if (idFacture != 0) {
    //   getFactureInfo();
    //   getFactureDetailsInfo();
    // } else {
    //   exercice = int.parse(txtDate.text.substring(0, 4));
    //   if (idFrom != 0) {
    //     getFactureInfo(transfert: true);
    //     getFactureDetailsInfo(transfert: true);
    //   }
    // }
  }

  @override
  void onClose() {
    focusDestination.dispose();
    focusClient.dispose();
    focusNumFa.dispose();

    txtInfoSupp.dispose();
    txtBasPage.dispose();
    txtPrixCondition.dispose();
    txtTransporteur.dispose();
    txtDelaiLivraison.dispose();
    txtDestination.dispose();
    txtGarantie.dispose();
    txtModePaiement.dispose();
    txtNum.dispose();
    txtDateOld.dispose();
    txtDate.dispose();
    txtClient.dispose();
    txtTime.dispose();
    txtTTC.dispose();
    txtHT.dispose();
    txtTva.dispose();
    txtTvaPourc.dispose();
    txtObjet.dispose();
    txtTimbre.dispose();
    super.onClose();
  }
}
