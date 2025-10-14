import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class BackgroundGradientWidget extends StatelessWidget {
  const BackgroundGradientWidget({
    super.key,
    required this.child,
    this.isPage = true,
  });

  final Widget child;
  final bool isPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: primaryGradient,
      ),
      child: isPage
          ? Scaffold(
              backgroundColor: Colors.transparent,
              body: child,
            )
          : child,
    );
  }
}
