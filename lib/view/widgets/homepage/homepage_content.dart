// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../../../core/class/responsive.dart';
// import '../../../core/constant/sizes.dart';
// import 'custom_appbar.dart';

// class HomePageContent extends StatelessWidget {
//   const HomePageContent({super.key});

//   @override
//   Widget build(BuildContext context) => Column(children: [
//         const CustomAppbar(),
//         const SizedBox(height: AppSizes.appPadding),
//         Column(children: [
//           Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Expanded(
//                 flex: 5,
//                 child: Column(children: [
//                   // const AnalyticCards(),
//                   const SizedBox(height: AppSizes.appPadding),
//                   // const Users(),
//                   if (Responsive.isMobile(context))
//                     const SizedBox(height: AppSizes.appPadding),
//                   // if (Responsive.isMobile(context)) const Discussions()
//                 ])),
//             if (!Responsive.isMobile(context))
//               const SizedBox(width: AppSizes.appPadding),
//             // if (!Responsive.isMobile(context)) const Expanded(flex: 2, child: Discussions())
//           ]),
//           // Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           //   Expanded(
//           //       flex: 5,
//           //       child: Column(children: [
//           //         const SizedBox(height: AppSizes.appPadding),
//           //         Row(
//           //             crossAxisAlignment: CrossAxisAlignment.start,
//           //             children: [
//           //               if (!Responsive.isMobile(context))
//           //                 const Expanded(flex: 2, child: TopReferals()),
//           //               if (!Responsive.isMobile(context))
//           //                 const SizedBox(width: AppSizes.appPadding),
//           //               const Expanded(flex: 3, child: Viewers())
//           //             ]),
//           //         const SizedBox(height: AppSizes.appPadding),
//           //         if (Responsive.isMobile(context))
//           //           const SizedBox(height: AppSizes.appPadding),
//           //         if (Responsive.isMobile(context)) const TopReferals(),
//           //         if (Responsive.isMobile(context))
//           //           const SizedBox(height: AppSizes.appPadding),
//           //         if (Responsive.isMobile(context)) const UsersByDevice()
//           //       ])),
//           //   if (!Responsive.isMobile(context))
//           //     const SizedBox(width: AppSizes.appPadding),
//           //   if (!Responsive.isMobile(context))
//           //     const Expanded(flex: 2, child: UsersByDevice())
//           // ])
//         ])
//       ]);
// }
