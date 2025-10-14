import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/gradient_bordered_card_widget.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({
    super.key,
    required this.title,
    required this.body,
    required this.isRead,
  });

  final String title, body;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return isRead
        ? Container(
            padding: EdgeInsets.all(defaultPadding),
            margin: EdgeInsets.only(bottom: defaultPadding),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: white2,
              borderRadius: BorderRadius.circular(defaultBorderRadius - 3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: secondaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  body,
                  style: secondaryTextStyle,
                ),
              ],
            ),
          )
        : GradientBorderedCardWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: secondaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  body,
                  style: secondaryTextStyle,
                ),
              ],
            ),
          );
  }
}
