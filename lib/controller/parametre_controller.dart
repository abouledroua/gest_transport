import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParametreController extends GetxController {
  String nomMagasin = "",
      telMagasin = "",
      villeMagasin = "",
      adrMagasin = "",
      faxMagasin = "",
      fixMagasin = "",
      activiteMagasin = "";

  void setParametre({
    required String telMagasin,
    required String nomMagasin,
    required String villeMagasin,
    required String adrMagasin,
    required String faxMagasin,
    required String fixMagasin,
    required String activiteMagasin,
  }) {
    this.telMagasin = telMagasin;
    this.nomMagasin = nomMagasin;
    this.villeMagasin = villeMagasin;
    this.adrMagasin = adrMagasin;
    this.faxMagasin = faxMagasin;
    this.fixMagasin = fixMagasin;
    this.activiteMagasin = activiteMagasin;
    update();
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    super.onInit();
  }
}
