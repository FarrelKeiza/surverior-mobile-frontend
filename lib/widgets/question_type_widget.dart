import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/custom_dropdown_button_labelled_widget.dart';
import 'package:surverior_frontend_mobile/widgets/gradient_bordered_card_widget.dart';
import 'package:surverior_frontend_mobile/widgets/question_widget.dart';
import 'package:surverior_frontend_mobile/widgets/question_type_model_widget.dart';

import 'package:surverior_frontend_mobile/providers/questionnaire_provider.dart';

const questionTypes = [
  {'label': 'Pilihan Ganda', 'icon': Icons.radio_button_checked},
  {'label': 'Daftar Centang', 'icon': Icons.check_circle_outline},
  {'label': 'Jawaban Singkat', 'icon': Icons.short_text},
  {'label': 'Paragraf', 'icon': Icons.notes},
  {'label': 'Petak Pilihan Ganda', 'icon': Icons.grid_on},
  {'label': 'Teks', 'icon': Icons.text_fields},
  {'label': 'Gambar', 'icon': Icons.image},
];

class QuestionTypeWidget extends HookWidget {
  const QuestionTypeWidget({
    super.key,
    required this.index,
    required this.controller,
    this.selectedQuestionType = 0,
  });

  final int index;
  final TextEditingController controller;
  final int selectedQuestionType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionWidget(
          index: index,
          title: "Pertanyaan $index",
        ),
        GradientBorderedCardWidget(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (selectedQuestionType != 5 && selectedQuestionType != 6) Expanded(
                    child: TextFormField(
                      controller: controller,
                      style: secondaryTextStyle,
                      decoration: InputDecoration(
                        hintText: "Pertanyaan",
                        hintStyle: secondaryTextStyle,
                      ),
                    ),
                  ),
                  if (selectedQuestionType == 5 || selectedQuestionType == 6)
                    Expanded(child: Container()),
                  Consumer<QuestionnaireProvider>(builder: (ctx, provider, widget) {
                    return IconButton(
                      onPressed: () {
                        provider.removeQuestion(index - 1);
                      },
                      icon: const Icon(Icons.close),
                      tooltip: "Remove",
                    );
                  })
                ],
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Consumer<QuestionnaireProvider>(builder: (ctx, provider, widget) {
                return CustomDropdownButtonLabelledWidget(
                  label: "Tipe Pertanyaan",
                  showLabel: false,
                  value: selectedQuestionType,
                  items: List<DropdownMenuItem<int>>.generate(
                    questionTypes.length,
                    (i) => DropdownMenuItem(
                      value: i,
                      child: QuestionTypeDropdownItem(
                        icon: questionTypes[i]['icon'] as IconData,
                        label: questionTypes[i]['label'] as String,
                        style: secondaryTextStyle,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    provider.updateType(index - 1, value);
                  },
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: black,
                  ),
                );
              }),
              switch (selectedQuestionType) {
                0 => QuestionTypeMultipleChoice(questionIndex: index - 1),
                1 => QuestionTypeCheckbox(questionIndex: index - 1),
                4 => QuestionTypeMultipleChoiceGrid(questionIndex: index - 1),
                5 => QuestionTypeText(questionIndex: index - 1),
                6 => QuestionTypeImage(questionIndex: index - 1),
                _ => const SizedBox.shrink(),
              },
            ],
          ),
        ),
      ],
    );
  }
}

class QuestionTypeDropdownItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextStyle? style;

  const QuestionTypeDropdownItem({
    super.key,
    required this.icon,
    required this.label,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Text(label, style: style),
      ],
    );
  }
}
