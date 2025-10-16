import 'package:flutter/material.dart';

import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class GradientActionIconButtonWidget extends StatelessWidget {
  const GradientActionIconButtonWidget(
      {super.key, required this.icon, this.onPressed});

  final Icon icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.circular(36),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: Colors.white,
        splashRadius: 24,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
    );
  }
}
