import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class QuestionToolbarWidget extends StatelessWidget {
  const QuestionToolbarWidget({super.key, this.onAdded});

  final void Function()? onAdded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: primaryColor,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButtonColored(
              onPressed: () {}, icon: const Icon(Icons.skip_previous)),
          IconButtonColored(
              onPressed: onAdded, icon: const Icon(Icons.add_circle)),
          IconButtonColored(
              onPressed: () {}, icon: const Icon(Icons.format_size)),
          IconButtonColored(
              onPressed: () {}, icon: const Icon(Icons.add_photo_alternate)),
          IconButtonColored(
              onPressed: () {}, icon: const Icon(Icons.skip_next)),
        ],
      ),
    );
  }
}

class IconButtonColored extends StatelessWidget {
  const IconButtonColored({super.key, this.onPressed, required this.icon});

  final void Function()? onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon.icon,
        color: primaryColor,
        size: icon.size,
        semanticLabel: icon.semanticLabel,
        textDirection: icon.textDirection,
      ),
    );
  }
}
