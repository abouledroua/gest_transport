import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';

import 'myuser_controller.dart';
import '../core/constant/data.dart';
import '../core/constant/sizes.dart';
import '../core/services/httprequest.dart';
import 'parametre_controller.dart';

class UpdateController extends GetxController {
  bool existMaj = false,
      existNewBcc = false,
      existNewBcf = false,
      existNewFa = false,
      existNewPf = false,
      existNewBr = false,
      existNewBl = false,
      existNewTrsf = false,
      existNewRc = false,
      existNewRf = false,
      existNewFv = false,
      existNewTrsc = false,
      existDemandAccess = false,
      _fetchingParametre = false,
      _fetchingUser = false;

  void _searchParametres() {
    if (!_fetchingParametre) _fetchParametre();
    const delayDuration = Duration(seconds: 11);
    Timer(delayDuration, _searchParametres);
  }

  Future<void> _fetchParametre() async {
    _fetchingParametre = true;
    try {
      final (response, success) = await httpRequest(ftpFile: 'GET_PARAMETRE_GENERALE.php');
      if (success) {
        ParametreController paramController = Get.find();
        String nom, tel, ville, adr, fax, fix, activite;
        var responsebody = jsonDecode(response!.body);
        for (var m in responsebody) {
          nom = m['NOM_MAGASIN'];
          ville = m['VILLE_MAGASIN'];
          tel = m['TEL_MAGASIN'];
          adr = m['ADRESSE_MAGASIN'];
          fax = m['FAX_MAGASIN'];
          fix = m['FIXE_MAGASIN'];
          activite = m['ACTIVITE'];

          paramController.setParametre(
            activiteMagasin: activite,
            adrMagasin: adr,
            faxMagasin: fax,
            fixMagasin: fix,
            nomMagasin: nom,
            telMagasin: tel,
            villeMagasin: ville,
          );
        }
      }
      _fetchingParametre = false;
    } catch (error) {
      if (kDebugMode) {
        debugPrint("erreur getParametres : $error");
      }
      _fetchingParametre = false;
    }
  }

  void _majUserAccess() {
    MyUserController userController = Get.find();
    if (!_fetchingUser && userController.idUser != 0) _fetchUserAccess();
    const delayDuration = Duration(seconds: 13);
    Timer(delayDuration, _majUserAccess);
  }

  Future<void> _fetchUserAccess() async {
    _fetchingUser = true;
    try {
      final (response, success) = await httpRequest(ftpFile: 'EXIST_USER.php');
      if (success) {
        var responsebody = jsonDecode(response!.body);
        MyUserController userController = Get.find();
        for (var m in responsebody) {
          userController.affichePrix = AppData.getInt(m, 'AFFICHE_PRIX') == 1;
          userController.caisse = AppData.getInt(m, 'CAISSE') == 1;
          userController.tresorerie = AppData.getInt(m, 'TRESORERIE') == 1;
          userController.rc = AppData.getInt(m, 'REGLEMENT_CLIENT') == 1;
          userController.rf = AppData.getInt(m, 'REGLEMENT_FOURNISSEUR') == 1;
          userController.livraison = AppData.getInt(m, 'LIVRAISON') == 1;
          userController.parametres = AppData.getInt(m, 'PARAMETRE') == 1;
          userController.retour = AppData.getInt(m, 'RETOUR') == 1;
          userController.stats = AppData.getInt(m, 'STATISTIQUE') == 1;
          userController.transaction = AppData.getInt(m, 'TRANSACTION') == 1;
          userController.transport = AppData.getInt(m, 'TRANSPORT') == 1;
          userController.update();
        }
        update();
      }
      _fetchingUser = false;
    } catch (error) {
      if (kDebugMode) {
        debugPrint("erreur _fetchUserAccess : $error");
      }
      _fetchingUser = false;
    }
  }

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context!);
    _majUserAccess();
    _searchParametres();
    super.onInit();
  }
}
