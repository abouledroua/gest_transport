import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/sizes.dart';
import '../core/services/settingservice.dart';
import 'home_controller.dart';

class FicheActivationController extends GetxController {
  late int idVersion, annee;
  late FocusNode focusNumCD, focusToken, focusNact1, focusNact2, focusNact3, focusNact4;
  String numCD = "", myId = '', mobile = '';
  bool loading = false,
      isNumCDValid = false,
      valNumCD = false,
      valNact1 = false,
      valTokken = false,
      saisieToken = false,
      valNact2 = false,
      valNact3 = false,
      valNact4 = false,
      valider = false,
      error = false;
  late TextEditingController txtNact1,
      txtNact2,
      txtNact4,
      txtNact3,
      txtNumCD,
      txtTokken,
      txtIdApp1,
      txtIdApp2,
      txtIdApp3,
      txtIdApp4;

  updateSaisiToken() {
    saisieToken = !saisieToken;
    update();
  }

  updateValider({required bool newValue}) {
    valider = newValue;
    update();
  }

  updateLoading({newloading, newerror}) {
    loading = newloading;
    error = newerror;
    update();
  }

  Future<bool> onWillPop() async =>
      (await showDialog(
          context: Get.context!,
          builder: (context) => AlertDialog(
                  title: Row(children: [
                    Icon(Icons.cancel_outlined, color: AppColor.red),
                    const Padding(padding: EdgeInsets.only(left: 8.0), child: Text('Annuler ?'))
                  ]),
                  content: const Text("Voulez-vous vraiment annuler tous les changements !!!"),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () => Get.back(result: false),
                        child: Text('non'.tr, style: TextStyle(color: AppColor.red))),
                    TextButton(
                        onPressed: () => Get.back(result: true),
                        child: Text('oui'.tr, style: TextStyle(color: AppColor.green)))
                  ]))) ??
      false;

  saveClient() {
    updateValider(newValue: true);
    txtNact1.text = txtNact1.text.removeAllWhitespace;
    txtNact2.text = txtNact2.text.removeAllWhitespace;
    txtNact3.text = txtNact3.text.removeAllWhitespace;
    txtNact4.text = txtNact4.text.removeAllWhitespace;

    valNumCD = txtNumCD.text.length < 4;
    valTokken = txtTokken.text.length < 4;
    valNact1 = txtNact1.text.length < 4;
    valNact2 = txtNact2.text.length < 4;
    valNact3 = txtNact3.text.length < 4;
    valNact4 = txtNact4.text.length < 4;
    if ((saisieToken && valTokken) || valNumCD || (!saisieToken && (valNact1 || valNact2 || valNact3 || valNact4))) {
      if (valNumCD) {
        focusNumCD.requestFocus();
      } else if (saisieToken && valTokken) {
        focusToken.requestFocus();
      } else if (!saisieToken) {
        if (valNact1) {
          focusNact1.requestFocus();
        } else if (valNact2) {
          focusNact2.requestFocus();
        } else if (valNact3) {
          focusNact3.requestFocus();
        } else if (valNact4) {
          focusNact1.requestFocus();
        }
      }
      debugPrint("Veuillez saisir les champs obligatoires !!!!");
      updateValider(newValue: false);
      AppData.mySnackBar(
          color: AppColor.red, title: 'Fiche Activation', message: "Veuillez remplir les champs oligatoire !!!!");
    } else {
      if (saisieToken) {
        if (txtTokken.text == "AD3#Y60_IG") {
          HomeController controller = Get.find();
          controller.setVersionDemo(false);
          Get.back(result: "success");
        } else {
          debugPrint("Tokken erronnée !!!!");
          updateValider(newValue: false);
          AppData.mySnackBar(color: AppColor.red, title: 'Fiche Activation', message: "Tokken erronnée !!!!");
        }
      } else {
        verifierNact();
      }
    }
  }

  verifierNumCD() {
    isNumCDValid = false;
    valNumCD = (txtNumCD.text.removeAllWhitespace.length < 7);
    if (valNumCD) {
      update();
    } else {
      String s = txtNumCD.text.substring(0, 2);
      if (s != '5G') {
        valNumCD = true;
        update();
      } else {
        idVersion = int.parse(txtNumCD.text.substring(2, 3));
        annee = int.parse(txtNumCD.text.substring(3, 4));
        numCD = txtNumCD.text.substring(4, 7);
        isNumCDValid = true;
        genererIdentifant();
        update();
      }
    }
  }

  genererNact() {
    try {
      String t1 = txtIdApp1.text;
      String t2 = txtIdApp2.text;
      String t3 = txtIdApp3.text;
      String t4 = txtIdApp4.text;

      String sn1 = AppData.system36New(AppData.getNumber(t2.substring(0, 1))) +
          AppData.system36New(AppData.getNumber(t2.substring(3, 4))) +
          AppData.system36New(AppData.getNumber(t2.substring(1, 2))) +
          AppData.system36New(AppData.getNumber(t2.substring(2, 3)));
      String sn2 = AppData.system36New(AppData.getNumber(t3.substring(2, 3))) +
          AppData.system36New(AppData.getNumber(t3.substring(0, 1))) +
          AppData.system36New(AppData.getNumber(t3.substring(1, 2))) +
          AppData.system36New(AppData.getNumber(t3.substring(3, 4)));
      String sn3 = AppData.system36New(AppData.getNumber(t1.substring(1, 2))) +
          AppData.system36New(AppData.getNumber(t1.substring(2, 3))) +
          AppData.system36New(AppData.getNumber(t1.substring(3, 4))) +
          AppData.system36New(AppData.getNumber(t1.substring(0, 1)));
      String sn4 = AppData.system36New(AppData.getNumber(t4.substring(1, 2))) +
          AppData.system36New(AppData.getNumber(t4.substring(0, 1))) +
          AppData.system36New(AppData.getNumber(t4.substring(2, 3))) +
          AppData.system36New(AppData.getNumber(t4.substring(3, 4)));

      return sn1 + sn2 + sn3 + sn4;
    } catch (e) {
      return '';
    }
  }

  activerDevice({required String cd, required String ns, required String na}) async {
    String serverDir = AppData.getServerDirectory();
    var url = "$serverDir/INSERT_ACTIVATION.php";
    debugPrint(url);
    AppData.saveIdentifiant(ns: ns, na: na, cd: cd);
    Uri myUri = Uri.parse(url);
    await http.post(myUri, body: {"BDD": AppData.dossier, "NS": ns, "NA": na}).then((response) async {
      if (response.statusCode == 200) {
        var responsebody = response.body;
        debugPrint("Activation Response=$responsebody");
        if (responsebody != "0") {
          HomeController controller = Get.find();
          controller.setVersionDemo(false);
          Get.back(result: "success");
        } else {
          updateValider(newValue: false);
          AppData.mySnackBar(title: 'Fiche Activation', message: "Probleme lors de l'ajout !!!", color: AppColor.red);
        }
      } else {
        updateValider(newValue: false);
        AppData.mySnackBar(
            title: 'Fiche Activation', message: "Probleme de Connexion avec le serveur !!!", color: AppColor.red);
      }
    }).catchError((error) {
      debugPrint("erreur insert Activation: $error");
      updateValider(newValue: false);
      AppData.mySnackBar(
          title: 'Fiche Activation', message: "Probleme de Connexion avec le serveur !!!", color: AppColor.red);
    });
  }

  verifierNact() async {
    updateValider(newValue: true);
    String gNact = genererNact();
    String myNact = txtNact1.text.toUpperCase() +
        txtNact2.text.toUpperCase() +
        txtNact3.text.toUpperCase() +
        txtNact4.text.toUpperCase();
    if (gNact == myNact && gNact.isNotEmpty) {
      String nid = txtIdApp1.text.toUpperCase() +
          txtIdApp2.text.toUpperCase() +
          txtIdApp3.text.toUpperCase() +
          txtIdApp4.text.toUpperCase();
      activerDevice(cd: txtNumCD.text.removeAllWhitespace.toUpperCase(), ns: nid, na: myNact);
    } else {
      updateValider(newValue: false);
      AppData.mySnackBar(title: 'Activation', message: "Code d'activation éronnée !!!!", color: AppColor.red);
    }
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    init();
    super.onInit();
  }

  init() {
    AppSizes.setSizeScreen(Get.context);
    isNumCDValid = false;
    focusNumCD = FocusNode();
    focusNact1 = FocusNode();
    focusNact2 = FocusNode();
    focusNact3 = FocusNode();
    focusNact4 = FocusNode();
    focusToken = FocusNode();
    txtNumCD = TextEditingController(text: kDebugMode ? '5G16BK9' : '');
    txtTokken = TextEditingController();
    txtNact1 = TextEditingController(text: kDebugMode ? '92PR' : '');
    txtNact2 = TextEditingController(text: kDebugMode ? '6RFT' : '');
    txtNact3 = TextEditingController(text: kDebugMode ? '97UP' : '');
    txtNact4 = TextEditingController(text: kDebugMode ? '2G3J' : '');
    txtIdApp1 = TextEditingController(text: '  ');
    txtIdApp2 = TextEditingController(text: '  ');
    txtIdApp3 = TextEditingController(text: '  ');
    txtIdApp4 = TextEditingController(text: '  ');
  }

  genererIdentifant() async {
    if (mobile.isEmpty) {
      mobile = await AppData.getAndroidId();
    }
    if (myId.isEmpty) {
      SettingServices sc = Get.find();
      myId = await sc.storage.read(key: 'ID') ?? '';
      if (myId.isEmpty) {
        myId = AppData.genererid();
        if (myId.length > 9) {
          myId = myId.substring(0, 9);
        }

        while (myId.length < 9) {
          myId = '${myId}a';
        }
        SettingServices sc = Get.find();
        await sc.storage.write(key: 'ID', value: myId);
      }
    }

    debugPrint('id=$myId mobile = $mobile');

    txtIdApp1.text =
        myId.substring(5, 6) + txtNumCD.text.substring(4, 5) + txtNumCD.text.substring(0, 1) + myId.substring(1, 2);
    txtIdApp2.text =
        myId.substring(0, 1) + txtNumCD.text.substring(2, 3) + myId.substring(7, 8) + txtNumCD.text.substring(6, 7);
    txtIdApp3.text =
        txtNumCD.text.substring(3, 4) + txtNumCD.text.substring(5, 6) + myId.substring(6, 7) + myId.substring(3, 4);
    txtIdApp4.text = txtNumCD.text.substring(1, 2) + myId.substring(2, 3) + myId.substring(4, 5) + myId.substring(8, 9);
    update();
  }

  @override
  void onClose() {
    focusNumCD.dispose();
    focusNact1.dispose();
    focusNact2.dispose();
    focusNact3.dispose();
    focusNact4.dispose();
    focusToken.dispose();
    txtNumCD.dispose();
    txtTokken.dispose();
    txtNact1.dispose();
    txtNact2.dispose();
    txtNact3.dispose();
    txtNact4.dispose();
    txtIdApp1.dispose();
    txtIdApp2.dispose();
    txtIdApp3.dispose();
    txtIdApp4.dispose();
    super.onClose();
  }
}
