import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/color.dart';
import '../../core/constant/sizes.dart';

class LoadingBarWidget extends StatelessWidget {
  final String? title;
  const LoadingBarWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) => SizedBox(
    height: AppSizes.fullHeight / 2,
    child: Center(
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(top: 6),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 25),
              Text(
                (title != null) ? title! : 'Chargement en cours'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColor.green2),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
