import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class ButtonBackAppBarWidget extends StatelessWidget {
  const ButtonBackAppBarWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigatorUtil.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          gradient: primaryGradient,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        child: IntrinsicWidth(
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios_new_rounded,
                color: white,
                size: 18,
              ),
              SizedBox(
                height: 20,
                child: VerticalDivider(
                  color: white,
                  thickness: 1,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: regular,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
