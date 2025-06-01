import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/fichetransport_controller.dart';
import '../../../core/constant/color.dart';

class EditTextFicheTransport extends StatelessWidget {
  final String text;
  final IconData icon;
  final int? maxLength;
  final FocusNode? focusNode;
  final bool? check;
  final bool error;
  final bool? readOnly;
  final bool isTTC;

  final TextEditingController mycontroller;
  final TextInputType keyboardType;
  final void Function()? onPressedIcon, onTapClear, onTapSearch;
  final Function(String)? onChanged;
  final int? nbline;
  const EditTextFicheTransport({
    super.key,
    required this.text,
    this.onChanged,
    this.isTTC = false,
    this.readOnly,
    this.focusNode,
    required this.icon,
    required this.mycontroller,
    this.onTapClear,
    this.onTapSearch,
    this.maxLength,
    this.nbline,
    this.onPressedIcon,
    this.check,
    required this.keyboardType,
    required this.error,
  });

  @override
  Widget build(BuildContext context) => GetBuilder<FicheTransportController>(
    builder: (controller) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(text, textAlign: TextAlign.center, style: Theme.of(Get.context!).textTheme.titleSmall),
        TextFormField(
          onTap: onTapSearch,
          focusNode: focusNode,
          onChanged: onChanged,
          controller: mycontroller,
          maxLength: maxLength,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: isTTC ? 24 : 16,
            fontWeight: isTTC ? FontWeight.bold : FontWeight.normal,
          ),
          enabled: !controller.valider,
          maxLines: nbline,
          keyboardType: keyboardType,
          readOnly: controller.valider || (readOnly != null && readOnly == true),
          textInputAction: nbline == null ? TextInputAction.newline : TextInputAction.next,
          decoration: InputDecoration(
            filled: isTTC,
            fillColor: AppColor.green,
            hintText: text,
            errorText: check == null || !check! ? null : 'Champs Obligatoire',
            hintStyle: TextStyle(fontSize: 14),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            suffixIcon: IconButton(onPressed: onPressedIcon, icon: Icon(icon)),
            border: OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.solid, width: 6, color: error ? AppColor.red : AppColor.black),
            ),
          ),
        ),
      ],
    ),
  );
}
