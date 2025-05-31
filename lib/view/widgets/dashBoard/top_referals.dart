import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../../core/constant/data.dart';
import '../../../core/constant/sizes.dart';
import 'referal_info_detail.dart';

class TopReferals extends StatelessWidget {
  const TopReferals({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: EdgeInsets.all(AppSizes.appPadding),
      decoration: BoxDecoration(color: AppColor.secondaryColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TopReferals',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColor.textColor),
              ),
              Text(
                'View All',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textColor.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.appPadding),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: referalData.length,
              itemBuilder: (context, index) => ReferalInfoDetail(info: referalData[index]),
            ),
          ),
        ],
      ),
    );
  }
}
