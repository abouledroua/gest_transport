import 'package:flutter/material.dart';

import '../../../core/class/responsive.dart';
import '../../../core/constant/data.dart';
import '../../../core/constant/sizes.dart';
import 'analytic_info_card.dart';

class AnalyticCards extends StatelessWidget {
  const AnalyticCards({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Responsive(
        mobile: AnalyticInfoCardGridView(
            crossAxisCount: size.width < 650 ? 2 : 4,
            childAspectRatio: size.width < 650 ? 2 : 1.5),
        tablet: const AnalyticInfoCardGridView(),
        desktop: AnalyticInfoCardGridView(
            childAspectRatio: size.width < 1400 ? 1.5 : 2.1));
  }
}

class AnalyticInfoCardGridView extends StatelessWidget {
  const AnalyticInfoCardGridView(
      {super.key, this.crossAxisCount = 4, this.childAspectRatio = 1.4});

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) => GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: analyticData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: AppSizes.appPadding,
          mainAxisSpacing: AppSizes.appPadding,
          childAspectRatio: childAspectRatio),
      itemBuilder: (context, index) =>
          AnalyticInfoCard(info: analyticData[index]));
}
