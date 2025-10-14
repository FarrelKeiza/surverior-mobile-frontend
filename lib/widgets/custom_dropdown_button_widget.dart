import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class CustomDropdownButtonWidget extends StatelessWidget {
  const CustomDropdownButtonWidget({
    super.key,
    required this.hintText,
    required this.items,
    this.isFilled = false,
    this.isPrimaryBorderColor = false,
    this.isEnabled = true,
    this.value,
    this.onChanged,
    this.prefixIcon = const SizedBox.shrink(),
    this.suffixIcon = const SizedBox.shrink(),
  });

  final String hintText;
  final bool isEnabled, isFilled, isPrimaryBorderColor;
  final Widget prefixIcon, suffixIcon;
  final List<DropdownMenuItem> items;
  final dynamic value;
  final Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      style: secondaryTextStyle.copyWith(
        fontSize: 14,
      ),
      value: value,
      items: items,
      onChanged: onChanged,
      icon: suffixIcon,
      dropdownColor: white,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: primaryTextStyle.copyWith(
          color: Colors.grey[400],
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
        prefixIcon: prefixIcon,
      ),
    );
  }
}
