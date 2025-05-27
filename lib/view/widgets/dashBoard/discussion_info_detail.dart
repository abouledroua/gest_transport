import 'package:flutter/material.dart';

import '../../../core/class/discussions_info_model.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/sizes.dart';

class DiscussionInfoDetail extends StatelessWidget {
  const DiscussionInfoDetail({super.key, required this.info});

  final DiscussionInfoModel info;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AppSizes.appPadding),
      padding: EdgeInsets.all(AppSizes.appPadding / 2),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset(
              info.imageSrc!,
              height: 38,
              width: 38,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.appPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.name!,
                    style: TextStyle(color: AppColor.textColor, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    info.date!,
                    style: TextStyle(
                      color: AppColor.textColor.withOpacity(0.5),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Icon(
            Icons.more_vert_rounded,
            color: AppColor.textColor.withOpacity(0.5),
            size: 18,
          )
        ],
      ),
    );
  }
}
