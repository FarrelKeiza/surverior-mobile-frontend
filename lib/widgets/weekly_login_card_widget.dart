import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class WeeklyLoginCardWidget extends StatelessWidget {
  const WeeklyLoginCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Login Mingguan",
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dayWidget(
                context,
                true,
                "1",
              ),
              dayWidget(
                context,
                true,
                "2",
              ),
              dayWidget(
                context,
                false,
                "3",
              ),
              dayWidget(
                context,
                false,
                "4",
              ),
              dayWidget(
                context,
                false,
                "5",
              ),
              dayWidget(
                context,
                false,
                "6",
              ),
              dayWidget(
                context,
                false,
                "7",
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget dayWidget(
    BuildContext context,
    bool isLogin,
    String day,
  ) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: isLogin ? tertiaryColor : white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: isLogin
            ? Icon(
                Icons.check,
                color: primaryColor,
              )
            : Text(
                day,
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  color: primaryColor,
                ),
              ),
      ),
    );
  }
}
