import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'side_bar_item.dart';

class MyMenuBar extends StatelessWidget {
  const MyMenuBar({super.key});

  @override
  Widget build(BuildContext context) => Container(
    width: 250,
    height: double.infinity,
    color: Colors.blueGrey[900],
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
          SidebarItem(icon: Icons.dashboard, title: "dashboard".tr, index: 0),
          SidebarItem(icon: Icons.emoji_transportation, title: 'transport'.tr, index: 1),
          SidebarItem(icon: Icons.delivery_dining_outlined, title: 'livraison_produit'.tr, index: 2),
          SidebarItem(icon: Icons.currency_exchange, title: 'livraison_argent'.tr, index: 3),
          SidebarItem(icon: Icons.person_pin_outlined, title: 'clients_fournisseurs'.tr, index: 4),
          SidebarItem(icon: Icons.drive_eta_outlined, title: 'transporteurs'.tr, index: 5),
          SidebarItem(icon: Icons.calendar_view_day_outlined, title: 'caisse'.tr, index: 6),
          SidebarItem(icon: Icons.settings, title: 'parametres'.tr, index: 7),
          SidebarItem(icon: Icons.logout, title: 'logout'.tr, index: 8),
        ],
      ),
    ),
  );
}
