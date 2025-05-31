import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../../core/constant/sizes.dart';
import 'radial_painter.dart';

class UsersByDevice extends StatelessWidget {
  const UsersByDevice({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.appPadding),
      child: Container(
        height: 350,
        decoration: BoxDecoration(color: AppColor.secondaryColor, borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(AppSizes.appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Users by device',
              style: TextStyle(color: AppColor.textColor, fontSize: 15, fontWeight: FontWeight.w700),
            ),
            Container(
              margin: EdgeInsets.all(AppSizes.appPadding),
              padding: EdgeInsets.all(AppSizes.appPadding),
              height: 230,
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                  bgColor: AppColor.textColor.withValues(alpha: 0.1),
                  lineColor: AppColor.primaryColor,
                  percent: 0.7,
                  width: 18.0,
                ),
                child: Center(
                  child: Text(
                    '70%',
                    style: TextStyle(color: AppColor.textColor, fontSize: 36, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.appPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle, color: AppColor.primaryColor, size: 10),
                      SizedBox(width: AppSizes.appPadding / 2),
                      Text(
                        'Desktop',
                        style: TextStyle(color: AppColor.textColor.withValues(alpha: 0.5), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.circle, color: AppColor.textColor.withValues(alpha:0.2), size: 10),
                      SizedBox(width: AppSizes.appPadding / 2),
                      Text(
                        'Mobile',
                        style: TextStyle(color: AppColor.textColor.withValues(alpha:0.5), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
