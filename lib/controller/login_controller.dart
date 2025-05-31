import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'myuser_controller.dart';
import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/routes.dart';
import '../core/constant/sizes.dart';
import '../core/services/httprequest.dart';
import '../core/services/settingservice.dart';
import 'parametre_controller.dart';
import 'update_controller.dart';

class LoginController extends GetxController {
  late TextEditingController userNameController, passController;
  String erreur = "";
  int type = 0;
  bool valider = false, wrongCredent = false, erreurServeur = false;

  void setValider(bool pValue) {
    valider = pValue;
    update();
  }

  void updateType(int value) {
    type = value;
    update();
  }

  Future<void> onValidate() async {
    setValider(true);
    String userName = AppData.removeEspace(userNameController.text.toUpperCase());
    String password = AppData.removeEspace(passController.text.toUpperCase());
    try {
      final (response, success) = await httpRequest(
        ftpFile: 'EXIST_USER.php',
        json: {"USERNAME": userName, "PASSWORD": password},
      );
      if (success) {
        erreurServeur = false;
        wrongCredent = false;
        erreur = "";
        var responsebody = jsonDecode(response!.body);
        if (responsebody == "0") {
          erreurServeur = true;
          setValider(false);
          return;
        }
        MyUserController userController = Get.find();
        for (var m in responsebody) {
          createVarUser(
            userController: userController,
            idUser: AppData.getInt(m, 'ID_USER'),
            paffprix: AppData.getInt(m, 'AFFICHE_PRIX') == 1,
            plivr: AppData.getInt(m, 'LIVRAISON') == 1,
            tresorerie: AppData.getInt(m, 'TRESORERIE') == 1,
            prc: AppData.getInt(m, 'REGLEMENT_CLIENT') == 1,
            prf: AppData.getInt(m, 'REGLEMENT_FOURNISSEUR') == 1,
            pretour: AppData.getInt(m, 'RETOUR') == 1,
            pcaisse: AppData.getInt(m, 'CAISSE') == 1,
            ptransport: AppData.getInt(m, 'TRANSPORT') == 1,
            pstat: AppData.getInt(m, 'STATISTIQUE') == 1,
            ptrans: AppData.getInt(m, 'TRANSACTION') == 1,
            parametre: AppData.getInt(m, 'PARAMETRE') == 1,
            password: password,
            userName: userName,
          );
        }
        if (userController.idUser == 0) {
          effacerLastUser();
          String msg = "Nom d' 'utilisateur ou mot de passe invalide !!!";
          wrongCredent = true;
          if (kDebugMode) {
            debugPrint(msg);
          }
          setValider(false);
          AppData.mySnackBar(title: 'Login', message: msg, color: AppColor.red);
        }
        setValider(false);
      } else {
        erreur = " seurveur 1";
        erreurServeur = true;
        AppData.mySnackBar(
          title: 'Login',
          message: "Probleme lors de la connexion avec le serveur !!!",
          color: AppColor.red,
        );
        if (kDebugMode) {
          debugPrint("Probleme lors de la connexion avec le serveur !!!");
        }
        setValider(false);
      }
    } catch (error) {
      erreur = error.toString();
      erreurServeur = true;
      if (kDebugMode) {
        debugPrint("error : ${error.toString()}");
      }
      debugPrint("Probleme de Connexion avec le serveur 33 !!!");
      setValider(false);
    }
  }

  Future<void> createVarUser({
    required MyUserController userController,
    required int idUser,
    required String userName,
    required String password,
    required bool prc,
    required bool tresorerie,
    required bool paffprix,
    required bool parametre,
    required bool prf,
    required bool pcaisse,
    required bool pstat,
    required bool ptransport,
    required bool pretour,
    required bool plivr,
    required bool ptrans,
  }) async {
    userController.setUser(
      paffprix: paffprix,
      pcaise: pcaisse,
      plivr: plivr,
      pretour: pretour,
      pstats: pstat,
      ptransport: ptransport,
      pidUser: idUser,
      prc: prc,
      prf: prf,
      ptrans: ptrans,
      pparam: parametre,
      ppassword: password,
      ptres: tresorerie,
      puserName: userName,
    );

    if (kDebugMode) {
      debugPrint("Its Ok ----- Connected ----------------");
    }

    SettingServices c = Get.find();
    c.sharedPrefs.setString('LastUser-${AppData.dossier}', userName);
    c.sharedPrefs.setString('LastPass-${AppData.dossier}', password);
    c.sharedPrefs.setBool('LastConnected-${AppData.dossier}', true);
    int privacy = c.sharedPrefs.getInt('Privacy_${userController.idUser}') ?? 0;
    userNameController.text = "";
    passController.text = "";
    valider = false;
    if (privacy == 0) {
      if (kDebugMode) {
        debugPrint("Going to Privacy");
      }
      await Get.toNamed(AppRoute.privacy);
    }
    // UpdateController uCtr = Get.find();
    // KHALIHA EN CAS MAKANCH INTERNET WLA VERSION EXPIRER
    // uCtr.checkUpdate();
    Get.offAllNamed(AppRoute.listTransport);
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    initConnect();
    super.onInit();
  }

  Future<void> initConnect() async {
    AppSizes.setSizeScreen(Get.context!);
    AppData.reparerBDD(showToast: false);
    type = 0;
    //Get.reset();
    userNameController = TextEditingController();
    passController = TextEditingController();
    erreurServeur = false;
    wrongCredent = false;
    SettingServices c = Get.find();
    //effacerLastUser();
    String userPref = c.sharedPrefs.getString('LastUser-${AppData.dossier}') ?? "";
    String passPref = c.sharedPrefs.getString('LastPass-${AppData.dossier}') ?? "";
    bool connect = c.sharedPrefs.getBool('LastConnected-${AppData.dossier}') ?? false;
    if (userPref.isNotEmpty && connect) {
      userNameController.text = userPref;
      passController.text = passPref;
      onValidate();
    }
    if (Get.isRegistered<ParametreController>()) {
      Get.delete<ParametreController>();
    }
    Get.put(ParametreController());

    if (Get.isRegistered<UpdateController>()) {
      Get.delete<UpdateController>();
    }
    Get.put(UpdateController());
  }

  void effacerLastUser() {
    SettingServices c = Get.find();
    c.sharedPrefs.setString('LastUser-${AppData.dossier}', "");
    c.sharedPrefs.setString('LastPass-${AppData.dossier}', "");
    c.sharedPrefs.setBool('LastConnected-${AppData.dossier}', false);
  }

  @override
  void onClose() {
    userNameController.dispose();
    passController.dispose();
    super.onClose();
  }
}
