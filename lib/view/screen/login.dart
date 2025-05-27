import 'package:flutter/material.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../controller/login_controller.dart';
import '../../core/constant/color.dart';
import '../../core/constant/data.dart';
import '../widgets/login/imageheaderlogin.dart';
import '../widgets/login/logincredentialwidget.dart';
import 'mywidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    HomeController hControler = Get.find();
    bool keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    Get.put(LoginController());
    int hour = TimeOfDay.now().hour;
    return MyWidget(
      limitWidth: true,
      showDemo: false,
      backgroundColor: AppColor.white,
      child: PopScope(
        canPop: false,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 14),
                    const ImageHeaderLogin(),
                    const SizedBox(height: 14),
                    Center(
                      child: Text(
                        hour < 13 ? 'bonjour'.tr : 'bonsoir'.tr,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Center(
                      child: Text(
                        'login_title'.tr,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColor.greyblack),
                      ),
                    ),
                    const LoginCredentialWidget(),
                    if (hControler.isVersionDemo)
                      BlinkText(
                        'version_demo'.tr,
                        style: Theme.of(context).textTheme.headlineLarge,
                        beginColor: AppColor.white,
                        endColor: AppColor.red,
                      ),
                  ],
                ),
              ),
              if (!keyboardVisible)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Text(
                        '${"serveur".tr} : ${AppData.getServerName()}',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColor.greyblack),
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
