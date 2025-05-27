// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/color.dart';
import '../../core/constant/sizes.dart';
import '../../core/localization/change_local.dart';
import '../../core/services/settingservice.dart';

class MyWidget extends StatelessWidget {
  final SliverAppBar? mysliver;
  final Widget child;
  bool? showDemo;
  final bool limitWidth;
  final Widget? floatingActionButton;
  String? title;
  Widget? titleWidget;
  final List<Widget>? actions;
  final String? backgroudImage;
  final Color? backgroundColor, appBarColor, leadingIconColor;
  final Widget? drawer, leading, endDrawer;
  Function(bool)? onDrawerChanged;

  MyWidget({
    GlobalKey<ScaffoldState>? key,
    required this.child,
    this.showDemo,
    this.mysliver,
    this.backgroudImage,
    this.backgroundColor,
    this.appBarColor,
    this.title,
    this.drawer,
    this.endDrawer,
    this.limitWidth = false,
    this.leadingIconColor,
    this.actions,
    this.leading,
    this.onDrawerChanged,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    title ??= "";
    showDemo ??= true;
    SettingServices sc = Get.find();
    String lang = sc.sharedPrefs.getString("lang") ?? "fr";
    return SafeArea(
      child: Stack(
        children: [
          if (backgroudImage != null)
            Positioned.fill(
              child: Image(image: AssetImage(backgroudImage!), fit: BoxFit.fill),
            ),
          Container(
            alignment: Alignment.topCenter,
            child: Container(
              constraints: limitWidth ? BoxConstraints(maxWidth: AppSizes.maxWidth) : null,
              child: Scaffold(
                key: key,
                backgroundColor: backgroundColor ?? (backgroudImage != null ? Colors.transparent : AppColor.white),
                appBar: title!.isEmpty
                    ? null
                    : AppBar(
                        leadingWidth: 30,
                        automaticallyImplyLeading: false,
                        titleSpacing: 0,
                        iconTheme: const IconThemeData(color: AppColor.black),
                        elevation: 0,
                        actions: [
                          if (actions != null && lang != "ar") ...actions!, // <-- Add custom actions first
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                SettingServices sc = Get.find();
                                String lang = sc.sharedPrefs.getString("lang") ?? "fr";
                                final languages = {'fr': 'Français', 'en': 'English', 'ar': 'العربية'};
                                return DropdownButton<String>(
                                  value: lang,
                                  icon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      SizedBox(width: 8), // Space between text and icon
                                      Icon(Icons.language, color: Colors.blue),
                                    ],
                                  ),
                                  underline: Container(),
                                  dropdownColor: AppColor.primaryColor,
                                  items: languages.entries.map((entry) {
                                    return DropdownMenuItem<String>(
                                      value: entry.key,
                                      child: Text(entry.value, style: TextStyle(color: Colors.white)),
                                    );
                                  }).toList(),
                                  onChanged: (String? newLang) {
                                    if (newLang != null) {
                                      LocaleController controller = Get.find();
                                      controller.changeLang(newLang);
                                      setState(() {}); // Refresh dropdown
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                          if (actions != null && lang == "ar") ...actions!, // <-- Add custom actions first
                        ],
                        centerTitle: true,
                        backgroundColor: appBarColor ?? Theme.of(context).primaryColor,
                        leading:
                            leading ??
                            (Navigator.canPop(Get.context!)
                                ? IconButton(
                                    color: leadingIconColor ?? AppColor.black,
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.arrow_back),
                                  )
                                : null),
                        title: FittedBox(
                          child: Text(
                            title!,
                            style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColor.white),
                          ),
                        ),
                      ),
                floatingActionButton: floatingActionButton,
                drawer: drawer,
                endDrawer: endDrawer,
                onDrawerChanged: onDrawerChanged,
                resizeToAvoidBottomInset: true,
                body: Container(
                  decoration: BoxDecoration(
                    gradient: backgroundColor != null
                        ? null
                        : LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.grey.shade400, Colors.grey.shade300, Colors.grey.shade200],
                          ),
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
