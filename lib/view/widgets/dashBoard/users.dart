import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../../core/constant/sizes.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.appPadding),
      decoration: BoxDecoration(
        color: AppColor.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Users",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: AppColor.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
