import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../../core/constant/image_asset.dart';
import '../../../core/constant/sizes.dart';

class ImageHeaderLogin extends StatelessWidget {
  const ImageHeaderLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
      width: AppSizes.widthScreen / 2,
      height: AppSizes.heightScreen / 4,
      child: ClipOval(
          child: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(color: AppColor.grey, blurRadius: 28),
                BoxShadow(color: AppColor.greyFonce, blurRadius: 18),
                BoxShadow(color: AppColor.white, blurRadius: 28)
              ]),
              child: Image.asset(AppImageAsset.login))));
}
