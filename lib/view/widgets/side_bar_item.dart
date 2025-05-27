import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/data.dart';
import '../../core/constant/routes.dart';
import '../../core/localization/change_local.dart';

class SidebarItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final int index;

  const SidebarItem({super.key, required this.icon, required this.title, required this.index});

  @override
  State<SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem> {
  bool _isHovered = false;
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    _isSelected =
        (widget.index == 0 && currentRoute == AppRoute.homePage) ||
        (widget.index == 1 && currentRoute == AppRoute.listTransport);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onLongPressStart: (_) => setState(() => _isHovered = true),
        onLongPressEnd: (_) => setState(() => _isHovered = false),
        onPanStart: (_) => setState(() => _isHovered = true),
        onPanEnd: (_) => setState(() => _isHovered = false),
        child: Container(
          padding: const EdgeInsets.only(left: 6),
          color: _isSelected
              ? Colors.blue[700]
              : _isHovered
              ? Colors.blueGrey[700]
              : Colors.transparent,
          child: ListTile(
            leading: Icon(widget.icon, color: Colors.white),
            title: Text(widget.title, style: const TextStyle(color: Colors.white)),
            onTap: _isSelected
                ? null
                : () {
                    switch (widget.index) {
                      case 0:
                        Get.toNamed(AppRoute.homePage);
                        break;
                      case 1:
                        Get.toNamed(AppRoute.listTransport);
                        break;
                      case 9:
                        AppData.logout(question: true);
                        break;
                      case 8:
                        LocaleController contr = Get.find<LocaleController>();
                        if (contr.language == const Locale('fr')) {
                          contr.changeLang('en');
                        } else if (contr.language == const Locale('en')) {
                          contr.changeLang('ar');
                        } else if (contr.language == const Locale('ar')) {
                          contr.changeLang('fr');
                        }
                        break;
                      default:
                    }
                  },
            hoverColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
