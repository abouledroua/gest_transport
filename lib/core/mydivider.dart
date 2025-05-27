import 'package:flutter/material.dart';

import 'constant/color.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) => Container(
      width: 5,
      decoration: const BoxDecoration(border: Border(right: BorderSide(color: AppColor.black))),
      child: const Text(''));
}
