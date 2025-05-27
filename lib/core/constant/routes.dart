import 'package:get/get.dart';

import '../services/settingservice.dart';

class AppRoute {
  static const String login = "/Login";
  static const String privacy = "/Privacy";
  static const String homePage = "/HomePage";
  static const String activation = "/Activation";
  static const String apropos = "/Apropos";

  static const String listTransport = "/listTransport";
  static const String fichePersonne = "/FichePersonne";
  static const String detailsPersonne = "/DetailsPersonne";

  static const String listProduit = "/ListProduit";
  static const String ficheProduit = "/FicheProduit";
  static const String detailsProduit = "/DetailsProduit";

  static const String listFactures = "/ListFacture";
  static const String ficheFacture = "/FicheFactures";

  static const String listDonnee = "/ListDonnee";
  static const String ficheDonnee = "/FicheDonnee";

  static const String ficheServerName = "/FicheServerName";

  static const String connectDossier = "/ConnectDossier";

  static void goToPage({required int index, firstGo = false}) {
    SettingServices c = Get.find();
    c.sharedPrefs.setInt('CurrentIndex', index);
    if (firstGo) {
      Get.offAllNamed(getPageName(index: index));
    } else {
      Get.toNamed(getPageName(index: index));
    }
  }

  static String getPageName({required int index}) {
    switch (index) {
      case 0:
        return AppRoute.homePage;
      case 1:
        return AppRoute.listTransport;
      case 2:
        return AppRoute.homePage;
      case 3:
        return AppRoute.homePage;
      case 4:
        return AppRoute.homePage;
      case 5:
        return AppRoute.homePage;
      case 6:
        return AppRoute.homePage;
      case 7:
        return AppRoute.homePage;
      case 8:
        return AppRoute.homePage;
      default:
        return '';
    }
  }
}
