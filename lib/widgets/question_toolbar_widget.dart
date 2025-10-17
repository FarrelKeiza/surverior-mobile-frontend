import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/providers/questionnaire_provider.dart';

class QuestionToolbarWidget extends StatelessWidget {
  const QuestionToolbarWidget({
    super.key,
    this.onAdded,
    this.onAddedText,
    this.onAddedPhoto,
    this.page = 1,
  });

  final void Function()? onAdded;
  final void Function()? onAddedText;
  final void Function()? onAddedPhoto;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionnaireProvider>(
      builder: (context, provider, child) {
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
              if (provider.canGoPrevious)
                IconButtonColored(
                  onPressed: () => provider.previousPage(),
                  icon: const Icon(Icons.skip_previous),
                ),
              IconButtonColored(
                  onPressed: onAdded, icon: const Icon(Icons.add_circle)),
              IconButtonColored(
                  onPressed: onAddedText, icon: const Icon(Icons.format_size)),
              IconButtonColored(
                  onPressed: onAddedPhoto,
                  icon: const Icon(Icons.add_photo_alternate)),
              IconButtonColored(
                onPressed: provider.canGoNext ? () => provider.nextPage() : null,
                icon: const Icon(Icons.skip_next),
              ),
            ],
          ),
        );
      },
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
