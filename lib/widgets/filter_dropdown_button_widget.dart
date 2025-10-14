import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class FilterDropdownButtonWidget extends StatelessWidget {
  const FilterDropdownButtonWidget({
    super.key,
    required this.hintText,
    required this.items,
    this.isFilled = false,
    this.isPrimaryBorderColor = false,
    this.isEnabled = true,
    this.value,
    this.onChanged,
    this.suffixIcon = const SizedBox.shrink(),
  });

  final String hintText;
  final bool isEnabled, isFilled, isPrimaryBorderColor;
  final Widget suffixIcon;
  final List<DropdownMenuItem> items;
  final dynamic value;
  final Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: DropdownButtonFormField(
        style: secondaryTextStyle.copyWith(
          fontSize: 14,
        ),
        padding: EdgeInsets.zero,
        value: value,
        items: items,
        onChanged: onChanged,
        icon: suffixIcon,
        dropdownColor: white,
        isDense: true,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: primaryTextStyle.copyWith(
            color: Colors.grey[400],
          ),
          filled: isFilled,
          fillColor: white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
        ),
      ),
    );
  }
}
