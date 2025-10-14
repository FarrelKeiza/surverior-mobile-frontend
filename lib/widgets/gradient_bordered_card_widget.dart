import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class GradientBorderedCardWidget extends StatelessWidget {
  const GradientBorderedCardWidget({
    super.key,
    required this.child,
    this.padding = 20,
  });

  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      margin: EdgeInsets.only(bottom: defaultPadding),
      decoration: BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(defaultBorderRadius - 3),
        ),
        child: child,
      ),
    );
  }
}
