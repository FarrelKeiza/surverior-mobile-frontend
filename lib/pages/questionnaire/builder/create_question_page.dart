import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/button_back_app_bar_widget.dart';
import 'package:surverior_frontend_mobile/widgets/question_toolbar_widget.dart';
import 'package:surverior_frontend_mobile/widgets/question_type_widget.dart';
import 'package:surverior_frontend_mobile/widgets/gradient_action_icon_button_widget.dart';

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

class CreateQuestionPage extends HookWidget {
  const CreateQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final index = useState(1);
    final questionControllers = useState<List<TextEditingController>>(
        [TextEditingController()]);

    useEffect(() {
      return () {
        for (final c in questionControllers.value) {
          c.dispose();
        }
      };
    }, []);

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
                    child: Text("Halaman 1/1",
                        style: TextStyle(color: primaryColor)),
                  )
                ],
              ),
              const SizedBox(height: 15),
              for (int i = 0; i < index.value; i++)
                QuestionTypeWidget(
                  index: i + 1,
                  controller: questionControllers.value[i],
                ),
              QuestionToolbarWidget(
                onAdded: () {
                  index.value += 1;
                  questionControllers.value.add(TextEditingController());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
