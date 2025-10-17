import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/button_back_app_bar_widget.dart';
import 'package:surverior_frontend_mobile/widgets/question_toolbar_widget.dart';
import 'package:surverior_frontend_mobile/widgets/question_type_widget.dart';
import 'package:surverior_frontend_mobile/widgets/gradient_action_icon_button_widget.dart';

import 'package:surverior_frontend_mobile/providers/questionnaire_provider.dart';

// class CreateQuestionPage extends StatefulWidget {
//   const CreateQuestionPage({super.key});
//
//   @override
//   State<CreateQuestionPage> createState() => _CreateQuestionPageState();
// }
//
// class _CreateQuestionPageState extends State<CreateQuestionPage> {
//   TextEditingController question1Controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: white,
//         title: const ButtonBackAppBarWidget(title: "Buat Pertanyaan Kuesioner"),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(defaultPadding),
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               QuestionTypeWidget(
//                 index: 1,
//                 controller: question1Controller,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class CreateModel {
  final TextEditingController questionControllers;
  final int type;

  CreateModel({required this.questionControllers, this.type = 0});
}

class CreateQuestionPage extends HookWidget {
  const CreateQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionnaireProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: white,
            title: const ButtonBackAppBarWidget(title: "Buat Kuesioner"),
            actions: [
              GradientActionIconButtonWidget(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    size: 16,
                  )),
              const SizedBox(width: 5),
              GradientActionIconButtonWidget(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    size: 16,
                  )),
              SizedBox(
                width: defaultPadding,
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          "Halaman ${provider.currentPage}/${provider.maxPage}",
                          style: TextStyle(color: primaryColor),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Display questions for current page
                  for (int i = 0; i < provider.currentPageQuestions.length; i++)
                    QuestionTypeWidget(
                      index: i + 1,
                      controller: provider.currentPageQuestions[i].questionControllers,
                      selectedQuestionType: provider.currentPageQuestions[i].type,
                    ),
                  QuestionToolbarWidget(
                    page: provider.currentPage,
                    onAdded: () => provider.addQuestion(),
                    onAddedText: () => provider.addTextQuestion(),
                    onAddedPhoto: () => provider.addPhotoQuestion(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
