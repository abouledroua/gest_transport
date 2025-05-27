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
    child: ListView(
      children: [
        Container(
          constraints: const BoxConstraints(maxHeight: 100),
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.appPadding),
          child: Image.asset(AppImageAsset.logo),
        ),
        FittedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.appPadding),
            child: Text("app_title".tr, style: Theme.of(context).textTheme.titleMedium),
          ),
        ),
        const SizedBox(height: AppSizes.appPadding),
        DrawerListTile(title: "dashboard".tr, icon: Icons.home, myIndex: 0),
        DrawerListTile(title: 'transport'.tr, icon: Icons.emoji_transportation, myIndex: 1),
        DrawerListTile(title: 'livraison_produit'.tr, icon: Icons.production_quantity_limits, myIndex: 2),
        DrawerListTile(title: 'livraison_argent'.tr, icon: Icons.currency_exchange_sharp, myIndex: 3),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.appPadding * 2),
          child: Divider(color: AppColor.grey, thickness: 0.2),
        ),
        DrawerListTile(title: 'clients_fournisseurs'.tr, icon: Icons.person_2_outlined, myIndex: 4),
        DrawerListTile(title: 'transporteurs'.tr, icon: Icons.support_agent_outlined, myIndex: 5),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.appPadding * 2),
          child: Divider(color: AppColor.grey, thickness: 0.2),
        ),
        DrawerListTile(title: 'caisse'.tr, icon: Icons.attach_money_outlined, myIndex: 6),
        DrawerListTile(title: 'parametres'.tr, icon: Icons.settings, myIndex: 7),
        DrawerListTile(title: 'langue'.tr, icon: Icons.settings, myIndex: 8),
        DrawerListTile(title: 'logout'.tr, icon: Icons.logout, color: AppColor.red, myIndex: 9),
      ],
    ),
  );
}
