import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class CustomTextFormFieldLabelledWidget extends StatelessWidget {
  const CustomTextFormFieldLabelledWidget({
    super.key,
    required this.label,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.showLabel = true,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool showLabel;
  final Widget? prefixIcon, suffixIcon;

  String? _validateNumberInput(String? value) {
    if (textInputType == TextInputType.number &&
        value != null &&
        value.isNotEmpty) {
      final isNumber = double.tryParse(value) != null;
      if (!isNumber) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.text = controller.text.replaceAll(RegExp(r'[^0-9]'), '');
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        });
        return 'Hanya angka yang diperbolehkan';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: showLabel,
            child: Text(
              label,
              style: secondaryTextStyle.copyWith(
                fontWeight: bold,
              ),
            ),
          ),
          Visibility(
            visible: showLabel,
            child: const SizedBox(
              height: 10,
            ),
          ),
          TextFormField(
            cursorColor: primaryColor,
            controller: controller,
            keyboardType: textInputType,
            validator: _validateNumberInput,
            style: secondaryTextStyle.copyWith(
              fontSize: 14,
            ),
            inputFormatters: textInputType == TextInputType.number
                ? [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ]
                : null,
            decoration: InputDecoration(
              filled: true,
              fillColor: white,
              hintText: label,
              hintStyle: primaryTextStyle.copyWith(
                color: Colors.grey[400],
                fontStyle: FontStyle.normal,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: black),
              ),
              prefixIcon: prefixIcon is SizedBox &&
                      (prefixIcon as SizedBox).width == 0.0 &&
                      (prefixIcon as SizedBox).height == 0.0
                  ? null
                  : prefixIcon,
              suffixIcon: suffixIcon is SizedBox &&
                      (suffixIcon as SizedBox).width == 0.0 &&
                      (suffixIcon as SizedBox).height == 0.0
                  ? null
                  : suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
