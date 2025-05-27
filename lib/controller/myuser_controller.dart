import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyUserController extends GetxController {
  int idUser = 0;
  String username = "", password = "";
  bool transport = false,
      rc = false,
      rf = false,
      tresorerie = false,
      livraison = false,
      caisse = false,
      stats = false,
      parametres = false,
      retour = false,
      transaction = false,
      affichePrix = false;

  clearUser() {
    idUser = 0;
    username = "";
    password = "";
    transport = false;
    rc = false;
    rf = false;
    tresorerie = false;
    livraison = false;
    caisse = false;
    stats = false;
    parametres = false;
    retour = false;
    transaction = false;
    affichePrix = false;
  }

  setUser(
      {required int pidUser,
      required String puserName,
      required String ppassword,
      required bool ptransport,
      required bool prc,
      required bool prf,
      required bool ptres,
      required bool paffprix,
      required bool pparam,
      required bool plivr,
      required bool pcaise,
      required bool pstats,
      required bool pretour,
      required bool ptrans}) {
    idUser = pidUser;
    username = puserName;
    password = ppassword;
    transaction = ptrans;
    rc = prc;
    rf = prf;
    transport = ptransport;
    affichePrix = paffprix;
    livraison = plivr;
    tresorerie = ptres;
    caisse = pcaise;
    stats = pstats;
    retour = pretour;
    transaction = ptrans;
    parametres = pparam;
    update();
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    clearUser();
    super.onInit();
  }
}
