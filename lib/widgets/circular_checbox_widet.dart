import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class CircularChecboxWidet extends StatelessWidget {
  const CircularChecboxWidet({
    super.key,
    required this.text,
    this.size = 24,
    required this.value,
    required this.onTap,
  });

  final Widget text;
  final double size;
  final bool value;
  final Function(bool value) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(!value);
      },
      child: Row(
        children: [
          value
              ? Icon(
                  Icons.check_circle,
                  size: size,
                  color: primaryColor,
                )
              : Icon(
                  Icons.circle_outlined,
                  size: size,
                  color: const Color(0xffE5E7EB),
                ),
          const SizedBox(
            width: 10,
          ),
          Flexible(child: text),
        ],
      ),
    );
  }
}
