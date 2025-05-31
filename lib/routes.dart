import 'package:flutter/material.dart';

import 'core/constant/routes.dart';
import 'view/screen/dashboard_ai.dart';
import 'view/screen/ficheimpression.dart';
import 'view/screen/list_transport_page.dart';
import 'view/screen/login.dart';
import 'view/screen/privacy_policy.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoute.login: (context) => const LoginPage(),
  AppRoute.homePage: (context) => const DashboardPage(),
  AppRoute.privacy: (context) => const PrivacyPolicy(),
  AppRoute.impression: (context) => const FicheImpression(),
  // AppRoute.apropos: (context) => const AProposView(),
  // AppRoute.activation: (context) => const FicheActivation(),
  // AppRoute.ficheDonnee: (context) => const FicheDonnee(),
  // AppRoute.fichePersonne: (context) => const FichePersonne(),
  // AppRoute.ficheProduit: (context) => const FicheProduit(),
  // AppRoute.ficheFacture: (context) => const FicheFacture(),
  // AppRoute.detailsPersonne: (context) => const DetailsPersonneView(),
  // AppRoute.detailsProduit: (context) => const DetailsProduitView(),
  AppRoute.listTransport: (context) => const ListTransportPage(),
  // AppRoute.listPersonne: (context) => const ListPersonne(),
  // AppRoute.listProduit: (context) => const ListProduits(),
  // AppRoute.listFactures: (context) => const ListFactures(),
  // AppRoute.ficheServerName: (context) => const FicheServerName(),
  // AppRoute.connectDossier: (context) => const ConnectDossier()
};
