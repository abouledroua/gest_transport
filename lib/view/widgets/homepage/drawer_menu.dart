import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/color.dart';
import '../../../core/constant/image_asset.dart';
import '../../../core/constant/sizes.dart';
import 'drawer_list_tile.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
          child: ListView(children: [
        Container(
            constraints: const BoxConstraints(maxHeight: 100),
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.appPadding),
            child: Image.asset(AppImageAsset.logo)),
        FittedBox(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.appPadding),
                child: Text("app_title".tr, style: Theme.of(context).textTheme.titleMedium))),
        const SizedBox(height: AppSizes.appPadding),
        const DrawerListTile(title: 'Acceuil', icon: Icons.home, myIndex: 0),
        const DrawerListTile(title: 'Transport', icon: Icons.emoji_transportation, myIndex: 1),
        const DrawerListTile(title: 'Livraison Produit', icon: Icons.production_quantity_limits, myIndex: 2),
        const DrawerListTile(title: 'Livraison Argent', icon: Icons.currency_exchange_sharp, myIndex: 3),
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.appPadding * 2),
            child: Divider(color: AppColor.grey, thickness: 0.2)),
        const DrawerListTile(title: 'Clients', icon: Icons.person_2_outlined, myIndex: 4),
        const DrawerListTile(title: 'Fournisseurs', icon: Icons.support_agent_outlined, myIndex: 5),
        const DrawerListTile(title: 'Transporteurs', icon: Icons.directions_car_filled_sharp, myIndex: 6),
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.appPadding * 2),
            child: Divider(color: AppColor.grey, thickness: 0.2)),
        const DrawerListTile(title: 'Caisse', icon: Icons.attach_money_outlined, myIndex: 7),
        const DrawerListTile(title: 'Paramêtres', icon: Icons.settings, myIndex: 8),
        DrawerListTile(title: 'Logout', icon: Icons.logout, color: AppColor.red, myIndex: 9)
      ]));
}
