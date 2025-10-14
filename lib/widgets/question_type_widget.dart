import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/custom_dropdown_button_labelled_widget.dart';
import 'package:surverior_frontend_mobile/widgets/gradient_bordered_card_widget.dart';
import 'package:surverior_frontend_mobile/widgets/question_widget.dart';

class QuestionTypeWidget extends StatelessWidget {
  const QuestionTypeWidget({
    super.key,
    required this.index,
    required this.controller,
  });

  final int index;
  final TextEditingController controller;

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
                items: [
                  DropdownMenuItem(
                    child: Text(
                      "Pilihan Ganda",
                      style: secondaryTextStyle,
                    ),
                  ),
                ],
                onChanged: (value) {},
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: black,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
