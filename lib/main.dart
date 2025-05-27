import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controller/home_controller.dart';
import 'controller/myuser_controller.dart';
import 'core/constant/data.dart';
import 'core/constant/theme.dart';
import 'core/localization/change_local.dart';
import 'core/localization/translate.dart';
import 'core/mycustomscrollbehavior.dart';
import 'core/services/settingservice.dart';
import 'routes.dart';
import 'view/screen/welcome.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialService();
  if (AppData.isAndroidAppMobile) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  configureApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(const MyApp()));
}

Future initialService() async {
  Get.put(HomeController());
  await Get.putAsync(() => SettingServices().init());
  Get.put(MyUserController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(), // <== add here
      debugShowCheckedModeBanner: false,
      translations: MyTranslation(),
      locale: controller.language,
      title: "app_title".tr,
      routes: routes,
      home: const WelcomePage(),
      theme: myTheme(context),
    );
  }
}
