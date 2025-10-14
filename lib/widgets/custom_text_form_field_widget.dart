import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.maxLines = 1,
    this.isPasswordField = false,
    this.isObscureText = false,
    this.isFilled = false,
    this.isPrimaryBorderColor = false,
    this.isEnabled = true,
    this.setObscureText,
    this.onFieldSubmitted,
    this.textInputType = TextInputType.text,
    this.prefixIcon = const SizedBox.shrink(),
    this.suffixIcon = const SizedBox.shrink(),
  });

  final String hintText;
  final TextEditingController controller;
  final bool isPasswordField,
      isObscureText,
      isEnabled,
      isFilled,
      isPrimaryBorderColor;
  final TextInputType textInputType;
  final Function()? setObscureText;
  final Function(String value)? onFieldSubmitted;
  final Widget prefixIcon, suffixIcon;
  final int maxLines;

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
    return TextFormField(
      style: secondaryTextStyle.copyWith(
        fontSize: 14,
      ),
      maxLines: maxLines,
      cursorColor: primaryColor,
      enabled: isEnabled,
      controller: controller,
      keyboardType: textInputType,
      obscureText: isObscureText,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: textInputType == TextInputType.number
          ? [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ]
          : null,
      validator: _validateNumberInput,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: primaryTextStyle.copyWith(
          color: Colors.grey[400],
          fontStyle: FontStyle.normal,
        ),
        filled: isFilled,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon:
            prefixIcon is SizedBox && (prefixIcon as SizedBox).child == null
                ? null
                : prefixIcon,
        suffixIcon: isPasswordField
            ? GestureDetector(
                onTap: setObscureText,
                child: Icon(
                  isObscureText ? Icons.visibility_off : Icons.visibility,
                  color: isObscureText ? Colors.grey[400] : primaryColor,
                ),
              )
            : suffixIcon,
      ),
    );
  }
}
