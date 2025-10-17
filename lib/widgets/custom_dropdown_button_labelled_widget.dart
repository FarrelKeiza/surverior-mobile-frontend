import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class CustomDropdownButtonLabelledWidget extends StatelessWidget {
  const CustomDropdownButtonLabelledWidget({
    super.key,
    required this.label,
    this.showLabel = true,
    this.prefixIcon,
    this.suffixIcon,
    this.value,
    this.paddingBottom = 20,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final bool showLabel;
  final Widget? prefixIcon, suffixIcon;
  final List<DropdownMenuItem> items;
  final dynamic value;
  final Function(dynamic)? onChanged;
  final double paddingBottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
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
          DropdownButtonFormField(
            isExpanded: true,
            isDense: true,
            items: items,
            value: value,
            onChanged: onChanged,
            icon: suffixIcon,
            style: secondaryTextStyle,
            decoration: InputDecoration(
              filled: true,
              fillColor: white,
              hintText: label,
              hintStyle: primaryTextStyle.copyWith(
                color: Colors.grey[400],
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
            ),
          ),
        ],
      ),
    );
  }
}
