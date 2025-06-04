import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/fichetransport_controller.dart';
import '../../controller/myuser_controller.dart';
import '../../core/constant/color.dart';
import '../../core/constant/data.dart';
import '../../core/constant/sizes.dart';
import '../widgets/fiche_transport/edittextfichetransport.dart';
import '../widgets/loadingbarwidget.dart';
import '../widgets/my_header.dart';
import 'myscreen.dart';

late int idTransport, exercice;

class FicheTransport extends StatelessWidget {
  const FicheTransport({super.key});

  @override
  Widget build(BuildContext context) {
    idTransport = Get.arguments['ID'] ?? 0;
    exercice = Get.arguments['EXERCICE'] ?? 0;

    FicheTransportController controller = Get.put(FicheTransportController(id: idTransport, ex: exercice));
    return MyScreen(
      child: WillPopScope(
        onWillPop: controller.onWillPop,
        child: Expanded(
          child: GetBuilder<FicheTransportController>(
            builder: (controller) => Obx(
              () => Column(
                children: [
                  MyHeaderWidget(title: 'Fiche_Transport'.tr),
                  (controller.loading.value || controller.loadingDepot || controller.loadingMagasin)
                      ? const LoadingBarWidget()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ficheFacture(controller, context),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GetBuilder<MyUserController> ficheFacture(
    FicheTransportController controller,
    BuildContext context,
  ) => GetBuilder<MyUserController>(
    builder: (userController) => Obx(
      () => ListView(
        primary: false,
        shrinkWrap: true,
        children: [
          Center(
            // Add this Center widget
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(border: Border.all()),
              constraints: BoxConstraints(maxWidth: min(AppSizes.widthScreen, 900)),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: myDateTimeField(
                      controller: controller.txtDate,
                      label: "Date".tr,
                      type: 1,
                      onTap: (value) {
                        controller.updateDate(value);
                      },
                      onTapClear: () {
                        controller.updateDate("");
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 4,
                    child: myDateTimeField(
                      controller: controller.txtTime,
                      label: "Heure".tr,
                      type: 2,
                      onTap: (value) {
                        controller.updateTime(value);
                      },
                      onTapClear: () {
                        controller.updateTime("");
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 16,
                    child: EditTextFicheTransport(
                      text: 'Client'.tr,
                      nbline: 1,
                      error: controller.valClient,
                      focusNode: controller.focusClient,
                      readOnly: true,
                      onTapClear: () {
                        controller.updateClientValue(pIdClient: 0, pNomClient: '');
                      },
                      onTapSearch: () {
                        // Get.toNamed(
                        //   AppRoute.listPersonne,
                        //   arguments: {'SELECT': true, 'TYPE': (type < 3) || (type == 7) ? 2 : 1},
                        // )?.then((value) {
                        //   if (value != null) {
                        //     controller.updateClientValue(pIdClient: value.id, pNomClient: value.nom);
                        //   }
                        // });
                      },
                      icon: Icons.multitrack_audio_rounded,
                      keyboardType: TextInputType.text,
                      mycontroller: controller.txtClient,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 8,
                    child: Visibility(
                      visible: controller.loadingDestination.value,
                      replacement: myDropDown(
                        label: 'Destination'.tr,
                        value: controller.dropDestination,
                        items: controller.myDropDestinationList,
                        onChanged: (value) {
                          controller.updateDropDestinationValue(value);
                        },
                        hint: "Choisir la Destination".tr,
                      ),
                      child: const Center(child: CircularProgressIndicator.adaptive()),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 16,
                    child: Visibility(
                      visible: controller.loadingDestination.value,
                      replacement: myDropDown(
                        label: 'Transporteur'.tr,
                        value: controller.dropDestination,
                        items: controller.myDropDestinationList,
                        onChanged: (value) {
                          controller.updateDropDestinationValue(value);
                        },
                        hint: "Choisir le Transporteur".tr,
                      ),
                      child: const Center(child: CircularProgressIndicator.adaptive()),
                    ),
                  ),

                  // SizedBox(width: 10),
                  // SizedBox(
                  //   width: 200,
                  //   child: EditTextFicheTransport(
                  //     text: 'Destination'.tr,
                  //     nbline: 1,
                  //     error: controller.valDestination,
                  //     focusNode: controller.focusDestination,
                  //     readOnly: true,
                  //     onTapClear: () {
                  //       controller.updateDestinationValue(pIdDestination: 0, pNomDestination: '');
                  //     },
                  //     onTapSearch: () {
                  //       // Get.toNamed(
                  //       //   AppRoute.listPersonne,
                  //       //   arguments: {'SELECT': true, 'TYPE': (type < 3) || (type == 7) ? 2 : 1},
                  //       // )?.then((value) {
                  //       //   if (value != null) {
                  //       //     controller.updateClientValue(pIdClient: value.id, pNomClient: value.nom);
                  //       //   }
                  //       // });
                  //     },
                  //     icon: Icons.multitrack_audio_rounded,
                  //     keyboardType: TextInputType.text,
                  //     mycontroller: controller.txtDestination,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),

          // const SizedBox(height: 10),
          //       const SizedBox(height: 15),
          //       Visibility(
          //         visible: controller.loadingMagasin,
          //         replacement: Visibility(
          //           visible: controller.errorMagasin || controller.nbMagasin > 1,
          //           child: EditTextFicheTransport(
          //             text: 'Magasin',
          //             nbline: 1,
          //             check: controller.valMagasin,
          //             focusNode: controller.focusMagasin,
          //             readOnly: true,
          //             onTapClear: () {
          //               controller.updateMagasinValue(pIdMagsin: 0, pNomMagsin: '');
          //             },
          //             onTapSearch: () {
          //               Get.toNamed(AppRoute.listDonnee, arguments: {'TYPE': 7})?.then((value) {
          //                 if (value != null) {
          //                   Donnee magasin = value;
          //                   controller.updateMagasinValue(pIdMagsin: magasin.id, pNomMagsin: magasin.designation);
          //                 }
          //               });
          //             },
          //             icon: Icons.multitrack_audio_rounded,
          //             keyboardType: TextInputType.text,
          //             mycontroller: controller.txtMagasin,
          //           ),
          //         ),
          //         child: const LoadingWidget(),
          //       ),
          //       const SizedBox(height: 15),
          //
          //
          //       // if (type == 5)
          //       //   Center(
          //       //       child: Container(
          //       //           constraints: BoxConstraints(maxWidth: AppSizes.widthScreen / 2),
          //       //           child: myCheckBox(
          //       //               context: context,
          //       //               text: 'Sans Facture',
          //       //               color: AppColor.purple.withValues(alpha: 0.5),
          //       //               valCheck: controller.valCheckSansFacture,
          //       //               onTap: (value) {
          //       //                 controller.updateCheckSansFacture(value);
          //       //               }))),
          //       if (type == 5) const SizedBox(height: 10),
          //       if (type == 5)
          //         EditTextFicheTransport(
          //           text: 'Transporteur',
          //           nbline: 1,
          //           readOnly: true,
          //           onTapClear: () {
          //             controller.updateTransporteurValue(pIdTransporteur: 0, pNomTransporteur: '');
          //           },
          //           onTapSearch: () {
          //             Get.toNamed(AppRoute.listPersonne, arguments: {'SELECT': true, 'TYPE': 3})?.then((value) {
          //               if (value != null) {
          //                 controller.updateTransporteurValue(pIdTransporteur: value.id, pNomTransporteur: value.nom);
          //               }
          //             });
          //           },
          //           icon: Icons.multitrack_audio_rounded,
          //           keyboardType: TextInputType.text,
          //           mycontroller: controller.txtTransporteur,
          //         ),
          //       const SizedBox(height: 10),
          //       const Divider(color: AppColor.black, thickness: 2),
          //       Row(
          //         children: [
          //           if (type != 1 && type != 7 && type != 2)
          //             if (!controller.loadingDetails)
          //               Visibility(
          //                 visible: !controller.loadingDepot,
          //                 child: Column(
          //                   mainAxisSize: MainAxisSize.min,
          //                   children: [
          //                     InkWell(
          //                       onTap: () async {
          //                         ProduitFacture pf = ProduitFacture(
          //                           totalAchat: 0,
          //                           totalVente: 0,
          //                           desMarque: '',
          //                           desCouleur: '',
          //                           desFamille: '',
          //                           oldQte: 0,
          //                           idUnite: 0,
          //                           isService: true,
          //                           desProduit: '',
          //                           qteStock: 0,
          //                           desUnite: '',
          //                           desDepot: '',
          //                           idDepot: 0,
          //                           idProduit: 0,
          //                           ref: '',
          //                           qte: 0,
          //                           obs: '',
          //                           prixVente: 0,
          //                           prixAchat: 0,
          //                         );
          //                         addNewProduct(controller: controller, pf: pf, isService: true);
          //                       },
          //                       child: Ink(child: const Icon(Icons.home_repair_service_outlined, color: AppColor.blue2)),
          //                     ),
          //                     Text('Services', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColor.blue2)),
          //                   ],
          //                 ),
          //               ),
          //           Expanded(
          //             child: Center(
          //               child: Text(
          //                 'Liste des Articles (${controller.produits.length} article${controller.produits.length > 1 ? 's' : ''})',
          //                 style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          //               ),
          //             ),
          //           ),
          //           if (!controller.loadingDetails)
          //             Visibility(
          //               visible: !controller.loadingDepot,
          //               child: Column(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   InkWell(
          //                     onTap: () async {
          //                       if (controller.nbDepot > 1 && controller.depotDefault == null) {
          //                         Get.toNamed(AppRoute.listDonnee, arguments: {'TYPE': 6})?.then((value) {
          //                           if (value != null) {
          //                             controller.depotDefault = value;
          //                             selectProduit(controller);
          //                           }
          //                         });
          //                       } else {
          //                         selectProduit(controller);
          //                       }
          //                     },
          //                     child: Ink(child: const Icon(Icons.add_shopping_cart_outlined, color: AppColor.green2)),
          //                   ),
          //                   Text('Produits', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColor.green2)),
          //                 ],
          //               ),
          //             ),
          //         ],
          //       ),
          //       const SizedBox(height: 15),
          //       if (controller.produits.isEmpty && !controller.loadingDetails)
          //         Center(
          //           child: Text(
          //             controller.errorDetails ? 'Erreur de chargement' : 'Aucun Produits',
          //             style: Theme.of(
          //               context,
          //             ).textTheme.titleMedium!.copyWith(color: controller.errorDetails ? AppColor.red : AppColor.black),
          //           ),
          //         ),
          //       if (controller.loadingDetails) const Center(child: CircularProgressIndicator.adaptive()),
          //       if (controller.produits.isNotEmpty) myListOfProducts(controller),
          //       const SizedBox(height: 10),
          //       const Divider(color: AppColor.black, thickness: 2),
          //       if (type == 3 || type == 6) const SizedBox(height: 10),
          //       if (type == 3)
          //         EditTextFicheTransport(
          //           text: 'Prix et Conditions Valables',
          //           nbline: 1,
          //           icon: Icons.text_fields_outlined,
          //           keyboardType: TextInputType.text,
          //           mycontroller: controller.txtPrixCondition,
          //         ),
          //       if (type == 3) const SizedBox(height: 15),
          //       if (type == 3)
          //         EditTextFicheTransport(
          //           text: 'Délai de Livraison',
          //           nbline: 1,
          //           icon: Icons.text_fields_outlined,
          //           keyboardType: TextInputType.text,
          //           mycontroller: controller.txtDelaiLivraison,
          //         ),
          //       if (type == 3) const SizedBox(height: 15),
          //       if (type == 3)
          //         EditTextFicheTransport(
          //           text: 'Garantie',
          //           nbline: 1,
          //           icon: Icons.text_fields_outlined,
          //           keyboardType: TextInputType.text,
          //           mycontroller: controller.txtGarantie,
          //         ),
          //       if (type == 3) const SizedBox(height: 15),
          //       if (type == 3)
          //         EditTextFicheTransport(
          //           text: 'Mode de Paiement',
          //           nbline: 1,
          //           icon: Icons.text_fields_outlined,
          //           keyboardType: TextInputType.text,
          //           mycontroller: controller.txtModePaiement,
          //         ),
          //       if (type == 3) const SizedBox(height: 15),
          //       if (type == 3)
          //         EditTextFicheTransport(
          //           text: 'Objet',
          //           icon: Icons.text_fields_outlined,
          //           keyboardType: TextInputType.multiline,
          //           mycontroller: controller.txtObjet,
          //         ),
          //       // myDropDown(
          //       //     label: 'Organisme',
          //       //     value: controller.dropOrganisme,
          //       //     items: controller.myDropList,
          //       //     onChanged: (value) {
          //       //       controller.updateDropValue(value);
          //       //     },
          //       //     onClear: () {
          //       //       controller.updateDropValue(null);
          //       //     },
          //       //     hint: "Choisir l'Organisme"),
          //       if (type == 6) const SizedBox(height: 15),
          //       if (type == 6)
          //         EditTextFicheTransport(
          //           text: 'Info Supplémentaire',
          //           nbline: null,
          //           icon: Icons.info_outline,
          //           keyboardType: TextInputType.multiline,
          //           mycontroller: controller.txtInfoSupp,
          //         ),
          //       if (type == 3 || type == 6) const SizedBox(height: 10),
          //       if (type == 3 || type == 6) const Divider(color: AppColor.black, thickness: 2),
          //       if (controller.existPrix) myRowOfCheckBox(context, controller),
          //       const SizedBox(height: 15),
          //       if (controller.existPrix)
          //         EditTextFicheTransport(
          //           text: controller.valCheckTva ? "Montant HT" : "Montant Total",
          //           nbline: 1,
          //           isTTC: !controller.valCheckTva,
          //           readOnly: true,
          //           icon: Icons.numbers,
          //           keyboardType: TextInputType.number,
          //           mycontroller: controller.txtHT,
          //         ),
          //       if (controller.valCheckTva && controller.existPrix) const SizedBox(height: 15),
          //       if (controller.valCheckTva && controller.existPrix)
          //         Row(
          //           children: [
          //             SizedBox(
          //               width: 120,
          //               child: EditTextFicheTransport(
          //                 text: "% Tva",
          //                 nbline: 1,
          //                 onChanged: (value) {
          //                   controller.updateTvapP(value);
          //                 },
          //                 icon: Icons.percent,
          //                 keyboardType: TextInputType.number,
          //                 mycontroller: controller.txtTvaPourc,
          //               ),
          //             ),
          //             SizedBox(width: AppSizes.widthScreen / 20),
          //             Expanded(
          //               child: EditTextFicheTransport(
          //                 text: "Montant Tva",
          //                 nbline: 1,
          //                 readOnly: true,
          //                 icon: Icons.numbers,
          //                 keyboardType: TextInputType.number,
          //                 mycontroller: controller.txtTva,
          //               ),
          //             ),
          //           ],
          //         ),
          //       if (controller.valCheckTimbre && controller.existPrix) const SizedBox(height: 15),
          //       if (controller.valCheckTimbre && controller.existPrix)
          //         EditTextFicheTransport(
          //           text: "Montant Timbre (1%)",
          //           nbline: 1,
          //           readOnly: true,
          //           icon: Icons.numbers,
          //           keyboardType: TextInputType.number,
          //           mycontroller: controller.txtTimbre,
          //         ),
          //       if (controller.valCheckTva && controller.existPrix) const SizedBox(height: 15),
          //       if (controller.valCheckTva && controller.existPrix)
          //         EditTextFicheTransport(
          //           text: "Montant TTC",
          //           nbline: 1,
          //           isTTC: true,
          //           readOnly: true,
          //           icon: Icons.numbers,
          //           keyboardType: TextInputType.number,
          //           mycontroller: controller.txtTTC,
          //         ),
          //       const SizedBox(height: 10),
          //       if (type != 6) const Divider(color: AppColor.black, thickness: 2),
          //       if (type != 6) const SizedBox(height: 10),
          //       if (type != 6)
          //         EditTextFicheTransport(
          //           text: "Bas de Page",
          //           nbline: null,
          //           icon: Icons.note_alt_outlined,
          //           keyboardType: TextInputType.multiline,
          //           mycontroller: controller.txtBasPage,
          //         ),
          //       const SizedBox(height: 20),
          //       if (controller.valider)
          //         const Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [CircularProgressIndicator.adaptive(), SizedBox(width: 20), Text("validation en cours ...")],
          //         ),
          //       if (!controller.valider && !controller.error && !controller.loadingDetails && !controller.errorDetails)
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: [
          //             MyButtonFiches(
          //               onPressed: () {
          //                 AwesomeDialog(
          //                   context: context,
          //                   dialogType: DialogType.warning,
          //                   showCloseIcon: true,
          //                   btnCancelText: "Non",
          //                   btnOkText: "Oui",
          //                   onDismissCallback: (type) {},
          //                   btnCancelOnPress: () {},
          //                   width: AppSizes.widthScreen,
          //                   btnOkOnPress: () {
          //                     Get.back();
          //                   },
          //                   desc: 'Voulez-vous vraiment annuler tous les changements !!!',
          //                 ).show();
          //               },
          //               borderColor: AppColor.red,
          //               backgroundcolor: AppColor.white,
          //               text: 'Annuler',
          //               textColor: AppColor.red,
          //             ),
          //             MyButtonFiches(
          //               onPressed: () {
          //                 controller.saveFacture();
          //               },
          //               borderColor: AppColor.white,
          //               backgroundcolor: AppColor.green,
          //               text: 'Valider',
          //               textColor: AppColor.white,
          //             ),
          //           ],
          //         ),
          //       const SizedBox(height: 20),
        ],
      ),
    ),
  );

  // myRowOfCheckBox(BuildContext context, FicheFactureController controller) {
  //   double maxConstr = AppSizes.widthScreen * 9 / 23;
  //   return SizedBox(
  //     height: 50,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           constraints: BoxConstraints(maxWidth: maxConstr),
  //           child: myCheckBox(
  //             context: context,
  //             text: 'Tva',
  //             color: AppColor.red,
  //             valCheck: controller.valCheckTva,
  //             onTap: (value) {
  //               controller.updateCheckTva(value);
  //             },
  //           ),
  //         ),
  //         if (controller.valCheckTva) SizedBox(width: AppSizes.widthScreen / 20),
  //         if (controller.valCheckTva)
  //           Container(
  //             constraints: BoxConstraints(maxWidth: maxConstr),
  //             child: myCheckBox(
  //               context: context,
  //               text: 'Timbre',
  //               color: AppColor.orange,
  //               valCheck: controller.valCheckTimbre,
  //               onTap: (value) {
  //                 controller.updateCheckTimbre(value);
  //               },
  //             ),
  //           ),
  //       ],
  //     ),
  //   );
  // }

  // myListOfProducts(FicheFactureController controller) => ListView.builder(
  //   itemCount: controller.produits.length,
  //   shrinkWrap: true,
  //   primary: false,
  //   padding: EdgeInsets.zero,
  //   itemBuilder: (context, index) {
  //     MyUserController userController = Get.find();
  //     ProduitFacture item = controller.produits[index];
  //     return Card(
  //       elevation: 5,
  //       child: ListTile(
  //         tileColor: item.isService ? AppColor.blue2.withValues(alpha: 0.1) : AppColor.green2.withValues(alpha: 0.1),
  //         contentPadding: EdgeInsets.zero,
  //         title: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 4),
  //           child: Text(item.desProduit, style: Theme.of(Get.context!).textTheme.titleMedium),
  //         ),
  //         trailing: trailingOfListTile(item, controller, context),
  //         subtitle: subtitleOfListTile(item, controller, userController),
  //       ),
  //     );
  //   },
  // );

  // trailingOfListTile(ProduitFacture item, FicheFactureController controller, BuildContext context) => Padding(
  //   padding: const EdgeInsets.only(right: 4),
  //   child: Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       InkWell(
  //         onTap: () {
  //           if (Get.isRegistered<BottomAjouterProduitFactureController>()) {
  //             Get.delete<BottomAjouterProduitFactureController>();
  //           }
  //           controller.depotDefault = Donnee(canDelete: false, designation: item.desDepot, id: item.idDepot);
  //           Get.bottomSheet(
  //             BottomSheetWidgetAjouterProduitsFacture(
  //               existPrix: controller.existPrix,
  //               produit: item,
  //               type: type,
  //               isService: item.isService,
  //               desDepot: controller.depotDefault!.designation,
  //             ),
  //             isScrollControlled: true,
  //             isDismissible: false,
  //             enterBottomSheetDuration: const Duration(milliseconds: 600),
  //             exitBottomSheetDuration: const Duration(milliseconds: 600),
  //           ).then((value) {
  //             if (value != null) {
  //               ProduitFacture pf = value!;
  //               int index = controller.produits.indexOf(item);
  //               controller.produits[index] = pf;
  //               controller.updateHT();
  //             }
  //           });
  //         },
  //         child: Ink(child: const Icon(Icons.edit)),
  //       ),
  //       InkWell(
  //         onTap: () {
  //           //produit.qteStock - produit.qte + qte < 0
  //           if (type == 1 && item.oldQte > item.qteStock) {
  //             AppData.mySnackBar(title: title, message: "Stock insuffisant !!!", color: AppColor.red);
  //           } else {
  //             AwesomeDialog(
  //               context: context,
  //               dialogType: DialogType.question,
  //               showCloseIcon: true,
  //               title: 'Confirmation',
  //               btnOkText: "Oui",
  //               btnCancelText: "Non",
  //               width: AppSizes.widthScreen,
  //               btnOkOnPress: () {
  //                 int index = controller.produits.indexOf(item);
  //                 controller.produits.removeAt(index);
  //                 controller.updateHT();
  //               },
  //               btnCancelOnPress: () {},
  //               desc: 'Voulez vraiment supprimer ce produit \n ${item.desProduit}?',
  //             ).show();
  //           }
  //         },
  //         child: Ink(child: Icon(Icons.clear, color: AppColor.red)),
  //       ),
  //     ],
  //   ),
  // );

  // subtitleOfListTile(ProduitFacture item, FicheFactureController controller, MyUserController userController) =>
  //     Padding(
  //       padding: const EdgeInsets.only(left: 8.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           if (!item.isService)
  //             Text(
  //               'Dépôt : ${item.desDepot}',
  //               textAlign: TextAlign.start,
  //               style: Theme.of(Get.context!).textTheme.titleSmall!.copyWith(color: AppColor.black),
  //             ),
  //           if (item.ref.removeAllWhitespace.isNotEmpty)
  //             Text(
  //               'Réference : ${item.ref}',
  //               textAlign: TextAlign.start,
  //               style: Theme.of(Get.context!).textTheme.titleSmall,
  //             ),
  //           if (item.desFamille.removeAllWhitespace.isNotEmpty)
  //             Text(
  //               'Famille : ${item.desFamille}',
  //               textAlign: TextAlign.start,
  //               style: Theme.of(Get.context!).textTheme.titleSmall,
  //             ),
  //           if (item.desMarque.removeAllWhitespace.isNotEmpty)
  //             Text(
  //               'Marque : ${item.desMarque}',
  //               textAlign: TextAlign.start,
  //               style: Theme.of(Get.context!).textTheme.titleSmall,
  //             ),
  //           if (item.desCouleur.removeAllWhitespace.isNotEmpty)
  //             Text(
  //               'Couleur : ${item.desCouleur}',
  //               textAlign: TextAlign.start,
  //               style: Theme.of(Get.context!).textTheme.titleSmall,
  //             ),
  //           Text(
  //             'Qte : ${AppData.formatMoney(item.qte)} ${item.desUnite}',
  //             textAlign: TextAlign.start,
  //             style: Theme.of(Get.context!).textTheme.titleSmall,
  //           ),
  //           if (userController.prixAchat && controller.existPrix && isAchat)
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'Achat : ${AppData.formatMoney(item.prixAchat)} DA',
  //                   textAlign: TextAlign.start,
  //                   style: Theme.of(Get.context!).textTheme.titleSmall,
  //                 ),
  //                 Text(
  //                   'Total Achat : ${AppData.formatMoney(item.totalAchat)} DA',
  //                   textAlign: TextAlign.start,
  //                   style: Theme.of(Get.context!).textTheme.titleSmall,
  //                 ),
  //               ],
  //             ),
  //           if (controller.existPrix && !isAchat)
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'Vente : ${AppData.formatMoney(item.prixVente)} DA',
  //                   textAlign: TextAlign.start,
  //                   style: Theme.of(Get.context!).textTheme.titleSmall,
  //                 ),
  //                 Text(
  //                   'Total Vente : ${AppData.formatMoney(item.totalVente)} DA',
  //                   textAlign: TextAlign.start,
  //                   style: Theme.of(Get.context!).textTheme.titleSmall,
  //                 ),
  //               ],
  //             ),
  //           if (item.obs.removeAllWhitespace.isNotEmpty)
  //             Text(
  //               'Observation : ${item.obs}',
  //               textAlign: TextAlign.start,
  //               style: Theme.of(Get.context!).textTheme.titleSmall,
  //             ),
  //         ],
  //       ),
  //     );

  // myCheckBox({
  //   required BuildContext context,
  //   required bool valCheck,
  //   required String text,
  //   required Color color,
  //   required Function(bool)? onTap,
  // }) => Center(
  //   child: Container(
  //     decoration: BoxDecoration(color: valCheck ? color : Colors.transparent, borderRadius: BorderRadius.circular(20)),
  //     child: CheckboxListTile(
  //       title: Text(text, style: Theme.of(context).textTheme.bodyLarge),
  //       value: valCheck,
  //       onChanged: (value) {
  //         if (value != null) {
  //           onTap!(value);
  //         }
  //       },
  //     ),
  //   ),
  // );

  // mytitle({required String label}) =>
  //     Text(label, textAlign: TextAlign.center, style: Theme.of(Get.context!).textTheme.titleSmall);

  // myDropDown({
  //   required String label,
  //   required String? value,
  //   required List<DropdownMenuItem<dynamic>>? items,
  //   required Function(dynamic) onChanged,
  //   required Function() onClear,
  //   required String hint,
  // }) => Column(
  //   mainAxisSize: MainAxisSize.min,
  //   children: [
  //     mytitle(label: label),
  //     DropdownButtonHideUnderline(
  //       child: Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 8),
  //         decoration: BoxDecoration(
  //           border: Border.all(color: AppColor.grey),
  //           borderRadius: BorderRadius.circular(6),
  //         ),
  //         child: Row(
  //           children: [
  //             Expanded(
  //               child: DropdownButton(
  //                 items: items,
  //                 isExpanded: true,
  //                 borderRadius: BorderRadius.circular(5),
  //                 hint: Text(hint),
  //                 value: value,
  //                 style: Theme.of(Get.context!).textTheme.titleSmall!.copyWith(color: AppColor.black),
  //                 iconSize: 0,
  //                 iconEnabledColor: AppColor.grey,
  //                 onChanged: onChanged,
  //               ),
  //             ),
  //             InkWell(
  //               onTap: onClear,
  //               child: Ink(child: const Icon(Icons.clear, color: AppColor.grey)),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   ],
  // );

  Text titleWidget({required String label}) =>
      Text(label, textAlign: TextAlign.center, style: Theme.of(Get.context!).textTheme.titleSmall);

  Column myDateTimeField({
    required TextEditingController controller,
    required Function()? onTapClear,
    required int type,
    required Function(String)? onTap,
    required String label,
  }) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      titleWidget(label: label),
      TextFormField(
        onTap: () {
          if (type == 2) {
            TimeOfDay selectedTime = controller.text.isEmpty
                ? TimeOfDay.now()
                : AppData.stringToTimeOfDay(controller.text);
            showTimePicker(context: Get.context!, initialTime: selectedTime).then((pickedDate) {
              if (pickedDate == null) {
                return;
              }
              selectedTime = pickedDate;
              onTap!(selectedTime.format(Get.context!));
            });
          } else {
            DateTime selectedDate = controller.text.isEmpty ? DateTime.now() : DateTime.parse(controller.text);
            showDatePicker(
              context: Get.context!,
              initialDate: selectedDate,
              firstDate: DateTime(2013),
              lastDate: DateTime(2113),
            ).then((pickedDate) {
              if (pickedDate == null) {
                return;
              }
              selectedDate = pickedDate;
              onTap!(DateFormat('yyyy-MM-dd').format(selectedDate));
            });
          }
        },
        readOnly: true,
        controller: controller,
        keyboardType: TextInputType.datetime,
        textAlign: TextAlign.center,
        style: Theme.of(Get.context!).textTheme.titleSmall,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 4),
          border: OutlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.solid, width: 6, color: AppColor.black),
          ),
        ),
      ),
    ],
  );

  // addNewProduct({
  //   required FicheFactureController controller,
  //   required ProduitFacture pf,
  //   String desDepot = "",
  //   bool isService = false,
  // }) {
  //   if (Get.isRegistered<BottomAjouterProduitFactureController>()) {
  //     Get.delete<BottomAjouterProduitFactureController>();
  //   }
  //   Get.bottomSheet(
  //     BottomSheetWidgetAjouterProduitsFacture(
  //       existPrix: controller.existPrix,
  //       produit: pf,
  //       type: type,
  //       desDepot: desDepot,
  //       isService: isService,
  //     ),
  //     isScrollControlled: true,
  //     isDismissible: false,
  //     enterBottomSheetDuration: const Duration(milliseconds: 600),
  //     exitBottomSheetDuration: const Duration(milliseconds: 600),
  //   ).then((value) {
  //     if (value != null) {
  //       pf = value!;
  //       controller.produits.add(pf);
  //       controller.updateHT();
  //     }
  //     if (controller.nbDepot > 1) {
  //       controller.depotDefault = null;
  //     }
  //   });
  // }

  // selectProduit(FicheFactureController controller) {
  //   Get.toNamed(
  //     AppRoute.listProduit,
  //     arguments: {
  //       'SEARCH': type != 5,
  //       'FILTER': type == 5,
  //       'SELECT_PRODUIT': true,
  //       'ID_DEPOT': controller.depotDefault!.id,
  //       "DEPOT_DES": controller.depotDefault!.designation,
  //     },
  //   )?.then((value) {
  //     if (value != null) {
  //       ProduitFacture pf = value;
  //       if (controller.produitExist(pf)) {
  //         if (controller.nbDepot > 1) {
  //           controller.depotDefault = null;
  //         }
  //         AppData.mySnackBar(title: 'Fiche $title', message: 'Produits déjà ajouté !!!', color: AppColor.red);
  //       } else {
  //         addNewProduct(controller: controller, pf: pf, desDepot: controller.depotDefault!.designation);
  //       }
  //     } else {
  //       if (controller.nbDepot > 1) {
  //         controller.depotDefault = null;
  //       }
  //     }
  //   });
  // }

  Column myDropDown({
    required String label,
    required String? value,
    required List<DropdownMenuItem<dynamic>>? items,
    required Function(dynamic) onChanged,
    Function()? onClear,
    required String hint,
  }) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      titleWidget(label: label),
      DropdownButtonHideUnderline(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.black, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Expanded(
                child: DropdownButton(
                  items: items,
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(5),
                  hint: Text(hint),
                  value: value,
                  style: Theme.of(Get.context!).textTheme.titleSmall!.copyWith(color: AppColor.black),
                  iconSize: 0,
                  iconEnabledColor: AppColor.grey,
                  onChanged: onChanged,
                ),
              ),
              if (onClear != null)
                InkWell(
                  onTap: onClear,
                  child: Ink(child: const Icon(Icons.clear, color: AppColor.grey)),
                ),
            ],
          ),
        ),
      ),
    ],
  );
}
