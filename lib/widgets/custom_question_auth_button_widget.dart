import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class CustomQuestionAuthButtonWidget extends StatelessWidget {
  const CustomQuestionAuthButtonWidget({
    super.key,
    required this.question,
    required this.buttonText,
    required this.page,
    this.isRegularPush = true,
  });

  final String question, buttonText;
  final Widget page;
  final bool isRegularPush;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question,
          style: primaryTextStyle,
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            if (isRegularPush) {
              NavigatorUtil.pushAndRemoveUntil(
                context,
                page,
              );
            } else {
              NavigatorUtil.pushToDynamicPage(
                context,
                page,
              );
            }
          },
          child: Text(
            buttonText,
            style: primaryTextStyle.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: white,
            ),
          ),
        ),
      ],
    );
  }
}
