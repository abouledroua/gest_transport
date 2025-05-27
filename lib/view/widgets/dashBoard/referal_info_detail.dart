import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/class/referal_info_model.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/sizes.dart';

class ReferalInfoDetail extends StatelessWidget {
  const ReferalInfoDetail({super.key, required this.info});

  final ReferalInfoModel info;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AppSizes.appPadding),
      padding: EdgeInsets.all(AppSizes.appPadding / 2),
      child: Row(
        children: [
          // Container(
          //   padding: EdgeInsets.all(AppSizes.appPadding / 1.5),
          //   height: 40,
          //   width: 40,
          //   decoration: BoxDecoration(
          //     color: info.color!.withOpacity(0.1),
          //     borderRadius: BorderRadius.circular(30),
          //   ),
          //   child: SvgPicture.asset(
          //     info.svgSrc!,
          //     color: info.color!,
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.appPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    info.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColor.textColor,
                    ),
                  ),
                  Text(
                    '${info.count!}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
