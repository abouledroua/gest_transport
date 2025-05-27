import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../../core/constant/sizes.dart';

class MyButtonHomePage extends StatelessWidget {
  final String text, image;
  final Function()? onTap;
  const MyButtonHomePage({super.key, required this.text, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: onTap,
      child: Ink(
          child: Container(
              decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border.all(width: 1, color: AppColor.white),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(8),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(width: AppSizes.widthScreen / 4, child: Image.asset(image, filterQuality: FilterQuality.high)),
                const Spacer(),
                FittedBox(child: Text(text, style: Theme.of(context).textTheme.headlineMedium)),
                const Spacer()
              ]))));
}
