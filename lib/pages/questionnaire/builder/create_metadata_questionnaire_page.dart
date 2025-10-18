import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/pages/questionnaire/builder/create_question_page.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/button_back_app_bar_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_dropdown_button_labelled_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_text_form_field_labelled_widget.dart';
import 'package:surverior_frontend_mobile/widgets/gradient_bordered_card_widget.dart';
import 'package:surverior_frontend_mobile/widgets/question_widget.dart';

import 'package:surverior_frontend_mobile/providers/category_provider.dart';
import 'package:surverior_frontend_mobile/providers/questionnaire_provider.dart';
import 'package:surverior_frontend_mobile/models/category.dart';

//
// class CreateMetadataQuestionnairePage extends StatefulWidget {
//   const CreateMetadataQuestionnairePage({
//     super.key,
//     this.isProfiling = true,
//   });
//
//   final bool isProfiling;
//
//   @override
//   State<CreateMetadataQuestionnairePage> createState() =>
//       _CreateMetadataQuestionnairePageState();
// }
//
// class _CreateMetadataQuestionnairePageState
//     extends State<CreateMetadataQuestionnairePage> {
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: white,
//         title: const ButtonBackAppBarWidget(title: "Buat Kuesioner"),
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               padding: EdgeInsets.all(defaultPadding),
//               physics: const BouncingScrollPhysics(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   GradientBorderedCardWidget(
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           controller: titleController,
//                           style: secondaryTextStyle.copyWith(
//                             fontSize: 20,
//                             fontWeight: bold,
//                           ),
//                           decoration: InputDecoration(
//                             hintText: "Judul Kuesioner",
//                             hintStyle: secondaryTextStyle.copyWith(
//                               fontSize: 20,
//                               fontWeight: bold,
//                             ),
//                           ),
//                         ),
//                         TextFormField(
//                           controller: descriptionController,
//                           style: secondaryTextStyle.copyWith(
//                             fontWeight: bold,
//                           ),
//                           decoration: InputDecoration(
//                             hintText: "Deskripsi Kuesioner",
//                             hintStyle: secondaryTextStyle,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Text(
//                     "Setelan Kuesioner",
//                     style: secondaryTextStyle.copyWith(
//                       fontWeight: bold,
//                       decoration: TextDecoration.underline,
//                       decorationColor: black,
//                     ),
//                   ),
//                   const QuestionWidget(
//                     index: 1,
//                     title: "Jumlah Target Responden",
//                   ),
//                   CustomTextFormFieldLabelledWidget(
//                     label: "Masukkan jumlah target responden",
//                     showLabel: false,
//                     textInputType: TextInputType.number,
//                     controller: titleController,
//                   ),
//                   const QuestionWidget(
//                     index: 2,
//                     title: "Batas Tanggal Pengisian",
//                   ),
//                   CustomTextFormFieldLabelledWidget(
//                     label: "Batas Tanggal Pengisian",
//                     showLabel: false,
//                     prefixIcon: Icon(
//                       Icons.calendar_month_rounded,
//                       color: Colors.grey[400],
//                     ),
//                     suffixIcon: Icon(
//                       Icons.keyboard_arrow_down_rounded,
//                       color: black,
//                     ),
//                     controller: titleController,
//                   ),
//                   const QuestionWidget(
//                     index: 3,
//                     title: "Kategori Kuesioner",
//                   ),
//                   CustomDropdownButtonLabelledWidget(
//                     label: "Kategori Kuesioner",
//                     showLabel: false,
//                     prefixIcon: Image.asset(
//                       "assets/png/category-grey.png",
//                     ),
//                     suffixIcon: Icon(
//                       Icons.keyboard_arrow_down_rounded,
//                       color: black,
//                     ),
//                     items: const [],
//                     onChanged: (value) {},
//                   ),
//                   Text(
//                     "Profiling Responden",
//                     style: secondaryTextStyle.copyWith(
//                       fontWeight: bold,
//                       decoration: TextDecoration.underline,
//                       decorationColor: black,
//                     ),
//                   ),
//                   const QuestionWidget(
//                     index: 1,
//                     title: "Profil",
//                   ),
//                   CustomDropdownButtonLabelledWidget(
//                     label: "Pilih Kategori Profil",
//                     showLabel: false,
//                     suffixIcon: Icon(
//                       Icons.keyboard_arrow_down_rounded,
//                       color: black,
//                     ),
//                     items: const [],
//                     onChanged: (value) {},
//                   ),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: EdgeInsets.all(defaultPadding),
//                 child: CustomButtonWidget(
//                   text: "Lanjut",
//                   suffixIcon: Icon(
//                     Icons.arrow_forward_ios_rounded,
//                     color: white,
//                   ),
//                   isLoading: false,
//                   onPressed: () {
//                     NavigatorUtil.pushToDynamicPage(
//                       context,
//                       const CreateQuestionPage(),
//                     );
//                   },
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class CreateMetadataQuestionnairePage extends HookWidget {
  const CreateMetadataQuestionnairePage({super.key, this.isProfiling = true});

  final bool isProfiling;

  @override
  Widget build(BuildContext context) {
    final categoryProvider = useMemoized(
        () => Provider.of<CategoryProvider>(context, listen: false));
    final questionnaireProvider = Provider.of<QuestionnaireProvider>(context);

    // Fetch categories once
    useEffect(() {
      categoryProvider.fetchCategories();
      return null;
    }, []);

    final categories = context.watch<CategoryProvider>().categories;
    // final isLoading = context.watch<CategoryProvider>().isLoading;
    final error = context.watch<CategoryProvider>().error;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title: const ButtonBackAppBarWidget(title: "Buat Kuesioner"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(defaultPadding),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientBorderedCardWidget(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: questionnaireProvider.titleController,
                          style: secondaryTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: bold,
                          ),
                          decoration: InputDecoration(
                            hintText: "Judul Kuesioner",
                            hintStyle: secondaryTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: bold,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller:
                              questionnaireProvider.descriptionController,
                          style: secondaryTextStyle.copyWith(
                            fontWeight: bold,
                          ),
                          decoration: InputDecoration(
                            hintText: "Deskripsi Kuesioner",
                            hintStyle: secondaryTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Setelan Kuesioner",
                    style: secondaryTextStyle.copyWith(
                      fontWeight: bold,
                      decoration: TextDecoration.underline,
                      decorationColor: black,
                    ),
                  ),
                  const QuestionWidget(
                    index: 1,
                    title: "Jumlah Target Responden",
                  ),
                  CustomTextFormFieldLabelledWidget(
                    label: "Masukkan jumlah target responden",
                    showLabel: false,
                    textInputType: TextInputType.number,
                    controller:
                        questionnaireProvider.targetRespondentController,
                  ),
                  const QuestionWidget(
                    index: 2,
                    title: "Batas Tanggal Pengisian",
                  ),
                  CustomTextFormFieldLabelledWidget(
                    label: "Batas Tanggal Pengisian",
                    showLabel: false,
                    prefixIcon: Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.grey[400],
                    ),
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: black,
                    ),
                    enableDateInput: true,
                    controller: questionnaireProvider.deadlineController,
                  ),
                  const QuestionWidget(
                    index: 3,
                    title: "Kategori Kuesioner",
                  ),
                  CustomDropdownButtonLabelledWidget(
                    label: "Kategori Kuesioner",
                    showLabel: false,
                    prefixIcon: Image.asset(
                      "assets/png/category-grey.png",
                    ),
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: black,
                    ),
                    items: categories
                            ?.map((cat) => DropdownMenuItem<Category>(
                                  value: cat,
                                  child: Text(cat.name ?? "Unknown"),
                                ))
                            .toList() ??
                        [],
                    onChanged: (value) {
                      questionnaireProvider
                          .setSelectedCategory(value as Category?);
                    },
                  ),
                  if (error.isNotEmpty) Text(error),
                  Text(
                    "Profiling Responden",
                    style: secondaryTextStyle.copyWith(
                      fontWeight: bold,
                      decoration: TextDecoration.underline,
                      decorationColor: black,
                    ),
                  ),
                  const QuestionWidget(
                    index: 1,
                    title: "Profil",
                  ),
                  CustomDropdownButtonLabelledWidget(
                    label: "Pilih Kategori Profil",
                    showLabel: false,
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: black,
                    ),
                    items: const [],
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: CustomButtonWidget(
                  text: "Lanjut",
                  suffixIcon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: white,
                  ),
                  isLoading: false,
                  onPressed: () {
                    final title =
                        questionnaireProvider.titleController.text.trim();
                    final description =
                        questionnaireProvider.descriptionController.text.trim();
                    final targetText = questionnaireProvider
                        .targetRespondentController.text
                        .trim();
                    final deadline =
                        questionnaireProvider.deadlineController.text.trim();
                    final category = questionnaireProvider.selectedCategory;

                    String? error;
                    if (title.isEmpty) {
                      error = 'Judul kuesioner wajib diisi';
                    } else if (description.isEmpty) {
                      error = 'Deskripsi kuesioner wajib diisi';
                    } else if (targetText.isEmpty) {
                      error = 'Jumlah target responden wajib diisi';
                    } else {
                      final target = int.tryParse(targetText);
                      if (target == null || target <= 0) {
                        error = 'Masukkan jumlah responden yang valid';
                      }
                    }
                    if (error == null && deadline.isEmpty) {
                      error = 'Batas tanggal pengisian wajib diisi';
                    }
                    if (error == null && category == null) {
                      error = 'Kategori kuesioner wajib dipilih';
                    }

                    if (error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    NavigatorUtil.pushToDynamicPage(
                      context,
                      const CreateQuestionPage(),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
