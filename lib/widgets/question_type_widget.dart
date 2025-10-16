import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/custom_dropdown_button_labelled_widget.dart';
import 'package:surverior_frontend_mobile/widgets/gradient_bordered_card_widget.dart';
import 'package:surverior_frontend_mobile/widgets/question_widget.dart';
import 'package:surverior_frontend_mobile/widgets/question_type_model_widget.dart';

// class QuestionTypeWidget extends StatelessWidget {
//   const QuestionTypeWidget({
//     super.key,
//     required this.index,
//     required this.controller,
//   });
//
//   final int index;
//   final TextEditingController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         QuestionWidget(
//           index: index,
//           title: "Pertanyaan $index",
//         ),
//         GradientBorderedCardWidget(
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: controller,
//                 style: secondaryTextStyle,
//                 decoration: InputDecoration(
//                   hintText: "Pertanyaan",
//                   hintStyle: secondaryTextStyle,
//                 ),
//               ),
//               SizedBox(
//                 height: defaultPadding,
//               ),
//               CustomDropdownButtonLabelledWidget(
//                 label: "Tipe Pertanyaan",
//                 showLabel: false,
//                 items: [
//                   DropdownMenuItem(
//                     child: Text(
//                       "Pilihan Ganda",
//                       style: secondaryTextStyle,
//                     ),
//                   ),
//                 ],
//                 onChanged: (value) {},
//                 suffixIcon: Icon(
//                   Icons.keyboard_arrow_down_rounded,
//                   color: black,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

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
  });

  final int index;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final selectedQuestionType = useState<int>(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionWidget(
          index: index,
          title: "Pertanyaan $index",
        ),
        GradientBorderedCardWidget(
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                style: secondaryTextStyle,
                decoration: InputDecoration(
                  hintText: "Pertanyaan",
                  hintStyle: secondaryTextStyle,
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              CustomDropdownButtonLabelledWidget(
                label: "Tipe Pertanyaan",
                showLabel: false,
                value: selectedQuestionType.value,
                items: List<DropdownMenuItem<int>>.generate(
                  questionTypes.length,
                  (index) => DropdownMenuItem(
                    value: index,
                    child: QuestionTypeDropdownItem(
                      icon: questionTypes[index]['icon'] as IconData,
                      label: questionTypes[index]['label'] as String,
                      style: secondaryTextStyle,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value != null) {
                    selectedQuestionType.value = value;
                  }
                },
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: black,
                ),
              ),
              switch (selectedQuestionType.value) {
                0 => const QuestionTypeMultipleChoice(),
                1 => const QuestionTypeCheckbox(),
                4 => const QuestionTypeMultipleChoiceGrid(),
                5 => const QuestionTypeText(),
                6 => const QuestionTypeImage(),
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
