import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import '../core/class/details_transport.dart';
import '../core/class/transport.dart';
import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/sizes.dart';
import '../core/services/httprequest.dart';

class DetailsTransportsController extends GetxController {
  late Transport item;
  RxBool loading = false.obs, error = false.obs;
  List<DetailsTransport> details = [];

  DetailsTransportsController(Transport pitem) {
    item = pitem;
  }

  updateBooleans({required newloading, required newerror, required type}) {
    loading.value = newloading;
    error.value = newerror;
    update();
  }

  Future getDetails({required bool showMessage}) async {
    if (!loading.value) {
      updateBooleans(newloading: true, newerror: false, type: 0);
      try {
        final (response, success) = await httpRequest(
          ftpFile: "GET_DETAILS_TRANSPORTS.php",
          json: {"ID_TRANSPORT": item.idTransport.toString(), "EXERCICE": item.exercice.toString()},
        );
        if (success) {
          var responsebody = jsonDecode(response!.body);

          for (var m in responsebody) {
            final e = DetailsTransport.fromJson(m);
            details.add(e);
          }
          updateBooleans(newloading: false, newerror: false, type: 0);
        } else {
          Get.back();
          AppData.mySnackBar(
            title: 'Liste des Transports'.tr,
            message: "Probleme de Connexion avec le serveur !!!",
            color: AppColor.red,
          );
        }
      } catch (error) {
        debugPrint("erreur getDetails: $error");
        Get.back();
        AppData.mySnackBar(
          title: 'Liste des Transports'.tr,
          message: "Probleme de Connexion avec le serveur !!!",
          color: AppColor.red,
        );
      }
    }
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    AppSizes.setSizeScreen(Get.context);
    getDetails(showMessage: true);
    super.onInit();
  }
}
