import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/models/department.dart';
import 'package:surverior_frontend_mobile/pages/questionnaire/builder/create_question_page.dart';
import 'package:surverior_frontend_mobile/providers/city_provider.dart';
import 'package:surverior_frontend_mobile/providers/city_provider.dart';
import 'package:surverior_frontend_mobile/providers/college_provider.dart';
import 'package:surverior_frontend_mobile/providers/college_provider.dart';
import 'package:surverior_frontend_mobile/providers/department_provider.dart';
import 'package:surverior_frontend_mobile/providers/department_provider.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/button_back_app_bar_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_dropdown_button_labelled_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_text_form_field_labelled_widget.dart';
import 'package:surverior_frontend_mobile/widgets/gradient_bordered_card_widget.dart';
import 'package:surverior_frontend_mobile/widgets/question_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_searchable_dropdown_widget.dart';

import 'package:surverior_frontend_mobile/providers/category_provider.dart';
import 'package:surverior_frontend_mobile/providers/questionnaire_provider.dart';
import 'package:surverior_frontend_mobile/models/category.dart';
import 'package:surverior_frontend_mobile/providers/education_provider.dart';
import 'package:surverior_frontend_mobile/models/education.dart';

import '../../../models/city.dart';
import '../../../models/college.dart';

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

final List<Map<String, String>> maritalOptions = [
  {'value': 'unmarried', 'label': 'Belum Menikah'},
  {'value': 'married', 'label': 'Menikah'},
  {'value': 'divorced', 'label': 'Cerai Hidup'},
  {'value': 'divorced_die', 'label': 'Cerai Mati'},
];

class CreateMetadataQuestionnairePage extends HookWidget {
  const CreateMetadataQuestionnairePage({super.key, this.isProfiling = true});

  final bool isProfiling;

  @override
  Widget build(BuildContext context) {
    final categoryProvider = useMemoized(
        () => Provider.of<CategoryProvider>(context, listen: false));
    final questionnaireProvider = Provider.of<QuestionnaireProvider>(context);

    final educationProvider = Provider.of<EducationProvider>(context);
    final educationProviderFetch =
        Provider.of<EducationProvider>(context, listen: false);
    useMemoized(() => educationProviderFetch.fetchEducations(),
        [educationProviderFetch]);
    final educations = educationProvider.educations ?? [];

    final collegeProvider = Provider.of<CollegeProvider>(context);
    final collegeProviderFetch =
        Provider.of<CollegeProvider>(context, listen: false);
    useMemoized(
        () => collegeProviderFetch.fetchColleges(), [collegeProviderFetch]);
    final colleges = collegeProvider.colleges ?? [];

    final cityProvider = Provider.of<CityProvider>(context);
    final cityProviderFetch = Provider.of<CityProvider>(context, listen: false);
    useMemoized(() => cityProviderFetch.fetchCities(), [cityProviderFetch]);
    final cities = cityProvider.cities ?? [];

    final departmentProvider = Provider.of<DepartmentProvider>(context);
    final departmentProviderFetch =
        Provider.of<DepartmentProvider>(context, listen: false);
    useMemoized(() => departmentProviderFetch.fetchDepartments(),
        [departmentProviderFetch]);
    final departments = departmentProvider.departments ?? [];

    // Fetch categories once
    useEffect(() {
      categoryProvider.fetchCategories();
      return null;
    }, []);

    final categories = context.watch<CategoryProvider>().categories;
    // final isLoading = context.watch<CategoryProvider>().isLoading;
    final error = context.watch<CategoryProvider>().error;

    final yearIn = useTextEditingController();
    final age = useTextEditingController();

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
                  CustomSearchableDropdownWidget<Category>(
                    label: 'Kategori Kuesioner',
                    showLabel: false,
                    value: categories == null
                        ? null
                        : (categories
                                    .firstWhere(
                                      (c) =>
                                          c.id ==
                                          questionnaireProvider
                                              .selectedCategory?.id,
                                      orElse: () => Category(),
                                    )
                                    .id ==
                                null
                            ? null
                            : categories.firstWhere(
                                (c) =>
                                    c.id ==
                                    questionnaireProvider.selectedCategory?.id,
                              )),
                    items: categories ?? [],
                    displayText: (cat) => cat.name ?? 'Unknown',
                    searchFilter: (cat, query) => (cat.name ?? '')
                        .toLowerCase()
                        .contains(query.toLowerCase()),
                    onChanged: (selectedCategory) {
                      questionnaireProvider
                          .setSelectedCategory(selectedCategory);
                    },
                    emptyMessage: 'No category found',
                    prefixIcon: Image.asset(
                      "assets/png/category-grey.png",
                    ),
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: black,
                    ),
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
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Switch(
                        value: questionnaireProvider.isProfiling,
                        onChanged: (value) {
                          questionnaireProvider.isProfiling = value;
                        },
                        activeTrackColor: primaryColor,
                        activeThumbColor: white,
                        inactiveTrackColor: const Color(0xFFD9D9D9),
                        inactiveThumbColor: const Color(0xFFB0B0B0),
                        trackOutlineColor:
                            WidgetStateColor.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return primaryColor;
                          }
                          return const Color(0xFFB0B0B0);
                        }),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '* Silahkan isi profil sesuai dengan kebutuhan Anda.',
                            style: GoogleFonts.onest(
                                fontSize: 11,
                                color: const Color(0xFF717171),
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic),
                          ),
                          Text(
                            '* Kosongkan kolom jika tidak diperlukan.',
                            style: GoogleFonts.onest(
                                fontSize: 11,
                                color: const Color(0xFF717171),
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      )
                    ],
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (child, animation) {
                      final offsetAnimation = Tween<Offset>(
                        begin: const Offset(0, 0.08),
                        end: Offset.zero,
                      ).animate(animation);
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: questionnaireProvider.isProfiling
                        ? Column(
                            key: const ValueKey('profiling_on'),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              CustomSearchableDropdownWidget<College>(
                                label: 'Asal Perguruan Tinggi',
                                showLabel: false,
                                // Find selected College object by id or pass null if not selected
                                value: colleges
                                            .firstWhere(
                                              (m) =>
                                                  m.id ==
                                                  questionnaireProvider
                                                      .collegeId,
                                              orElse: () =>
                                                  College(), // ensure College has nullable id
                                            )
                                            .id ==
                                        null
                                    ? null
                                    : colleges.firstWhere((m) =>
                                        m.id ==
                                        questionnaireProvider.collegeId),
                                items: colleges,
                                displayText: (c) => c.name ?? 'Unknown',
                                searchFilter: (c, query) => (c.name ?? '')
                                    .toLowerCase()
                                    .contains(query),
                                onChanged: (selectedCollege) {
                                  questionnaireProvider.collegeId =
                                      selectedCollege?.id;
                                },
                                emptyMessage: 'No major found',
                              ),
                              CustomSearchableDropdownWidget<Department>(
                                label: 'Bidang Keilmuan',
                                showLabel: false,
                                // Find selected College object by id or pass null if not selected
                                value: departments
                                            .firstWhere(
                                              (m) =>
                                                  m.id ==
                                                  questionnaireProvider
                                                      .departmentId,
                                              orElse: () =>
                                                  Department(), // ensure College has nullable id
                                            )
                                            .id ==
                                        null
                                    ? null
                                    : departments.firstWhere((m) =>
                                        m.id ==
                                        questionnaireProvider.departmentId),
                                items: departments,
                                displayText: (c) => c.name ?? 'Unknown',
                                searchFilter: (c, query) => (c.name ?? '')
                                    .toLowerCase()
                                    .contains(query),
                                onChanged: (selectedCollege) {
                                  questionnaireProvider.departmentId =
                                      selectedCollege?.id;
                                },
                                emptyMessage: 'No department found',
                              ),
                              CustomSearchableDropdownWidget<Education>(
                                label: 'Pendidikan Terakhir',
                                showLabel: false,
                                value: educations
                                            .firstWhere(
                                              (e) =>
                                                  e.id ==
                                                  questionnaireProvider
                                                      .educationId,
                                              orElse: () => Education(),
                                            )
                                            .id ==
                                        null
                                    ? null
                                    : educations.firstWhere((e) =>
                                        e.id ==
                                        questionnaireProvider.educationId),
                                items: educations,
                                displayText: (education) =>
                                    education.educationName ?? 'Unknown',
                                searchFilter: (education, query) =>
                                    (education.educationName ?? '')
                                        .toLowerCase()
                                        .contains(query),
                                onChanged: (selectedEducation) {
                                  questionnaireProvider.educationId =
                                      selectedEducation?.id;
                                },
                                emptyMessage: 'No education found',
                              ),
                              CustomTextFormFieldLabelledWidget(
                                label: "Tahun Masuk",
                                showLabel: false,
                                enableDateInput: true,
                                controller:
                                    questionnaireProvider.yearInController,
                              ),
                              CustomTextFormFieldLabelledWidget(
                                label: "Umur",
                                showLabel: false,
                                enableRangeInput: true,
                                controller: questionnaireProvider.ageController,
                              ),
                              CustomSearchableDropdownWidget<City>(
                                label: 'Domisili',
                                showLabel: false,
                                value: cities
                                            .firstWhere(
                                              (c) =>
                                                  c.id ==
                                                  questionnaireProvider.cityId,
                                              orElse: () => City(),
                                            )
                                            .id ==
                                        null
                                    ? null
                                    : cities.firstWhere((c) =>
                                        c.id == questionnaireProvider.cityId),
                                items: cities,
                                displayText: (city) => city.name ?? 'Unknown',
                                searchFilter: (city, query) => (city.name ?? '')
                                    .toLowerCase()
                                    .contains(query.toLowerCase()),
                                onChanged: (selectedCity) {
                                  questionnaireProvider.cityId =
                                      selectedCity?.id;
                                },
                                emptyMessage: 'No city found',
                              ),
                              CustomDropdownButtonLabelledWidget(
                                label: 'Jenis Kelamin',
                                showLabel: false,
                                value: questionnaireProvider.gender,
                                items: [
                                  DropdownMenuItem(
                                    value: null,
                                    child: Text('Pilih Jenis Kelamin',
                                        style: secondaryTextStyle),
                                  ),
                                  DropdownMenuItem(
                                    value: 'm',
                                    child: Text('Laki-laki',
                                        style: secondaryTextStyle),
                                  ),
                                  DropdownMenuItem(
                                    value: 'f',
                                    child: Text('Perempuan',
                                        style: secondaryTextStyle),
                                  ),
                                ],
                                onChanged: (value) {
                                  questionnaireProvider.gender =
                                      value as String?;
                                },
                              ),
                              CustomDropdownButtonLabelledWidget(
                                label: 'Status Pernikahan',
                                showLabel: false,
                                value: questionnaireProvider.marriedStatus,
                                items: [
                                  const DropdownMenuItem(
                                      value: null,
                                      child: Text('Status Pernikahan')),
                                  ...maritalOptions.map(
                                    (e) => DropdownMenuItem<String>(
                                      value: e['value']!,
                                      child: Text(
                                        e['label'] ?? e['value']!,
                                        style: secondaryTextStyle,
                                      ),
                                    ),
                                  )
                                ],
                                onChanged: (value) {
                                  questionnaireProvider.marriedStatus =
                                      value as String?;
                                },
                              ),
                              SizedBox(height: defaultPadding + 20),
                            ],
                          )
                        : const SizedBox.shrink(
                            key: ValueKey('profiling_off'),
                          ),
                  )
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
