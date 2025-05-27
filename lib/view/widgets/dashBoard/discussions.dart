import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../../core/constant/data.dart';
import '../../../core/constant/sizes.dart';
import 'discussion_info_detail.dart';

class Discussions extends StatelessWidget {
  const Discussions({super.key});

  @override
  Widget build(BuildContext context) => Container(
      height: 540,
      padding: const EdgeInsets.all(AppSizes.appPadding),
      decoration: BoxDecoration(color: AppColor.secondaryColor, borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Discussions', style: TextStyle(color: AppColor.textColor, fontWeight: FontWeight.w700, fontSize: 15)),
          Text('View All',
              style: TextStyle(color: AppColor.textColor.withOpacity(0.5), fontWeight: FontWeight.bold, fontSize: 13))
        ]),
        const SizedBox(height: AppSizes.appPadding),
        Expanded(
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: discussionData.length,
                itemBuilder: (context, index) => DiscussionInfoDetail(info: discussionData[index])))
      ]));
}
