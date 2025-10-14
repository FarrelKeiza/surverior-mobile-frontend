import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    super.key,
    required this.index,
    required this.title,
  });

  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: primaryGradient,
          ),
          child: Text(
            index.toString(),
            style: primaryTextStyle,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: secondaryTextStyle.copyWith(
            fontWeight: bold,
          ),
        )
      ],
    );
  }
}
