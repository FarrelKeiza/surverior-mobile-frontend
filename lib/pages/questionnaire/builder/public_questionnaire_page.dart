import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/pages/questionnaire/builder/finish_questionnaire_page.dart';
import 'package:surverior_frontend_mobile/providers/city_provider.dart';
import 'package:surverior_frontend_mobile/providers/college_provider.dart';
import 'package:surverior_frontend_mobile/providers/department_provider.dart';
import 'package:surverior_frontend_mobile/providers/education_provider.dart';
import 'package:surverior_frontend_mobile/providers/questionnaire_provider.dart';

import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/button_back_app_bar_widget.dart';
import 'package:surverior_frontend_mobile/widgets/gradient_chip_widget.dart';

import '../../../utils/navigator_util.dart';

class PublicQuestionnairePage extends StatelessWidget {
  const PublicQuestionnairePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title: const ButtonBackAppBarWidget(title: "Publikasi Kuesioner"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Consumer5<QuestionnaireProvider, CollegeProvider,
                  DepartmentProvider, CityProvider, EducationProvider>(
              builder: (context, questionnaireProvider, collegeProvider,
                  departmentProvider, cityProvider, educationProvider, _) {
            final int r = int.tryParse(
                    questionnaireProvider.targetRespondentController.text) ??
                0;
            final int s = questionnaireProvider.totalQuestions;
            final int harga = (r * 100) + (s * r * 100);
            final String formattedHarga =
                NumberFormat.decimalPattern('id').format(harga);
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Siap untuk mempublikasikan kuesioner Anda?',
                  style: GoogleFonts.onest(
                    color: black1,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/png/publish.png',
                      width: 324,
                      height: 324,
                    )
                  ],
                ),
                const SizedBox(height: 29),
                Text(
                  questionnaireProvider.titleController.text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.onest(
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  questionnaireProvider.descriptionController.text,
                  style: GoogleFonts.onest(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                // Updated: use real data from provider
                Row(
                  children: [
                    InformationWidget(
                      icon: Icons.question_mark,
                      label:
                          '${questionnaireProvider.totalQuestions} Pertanyaan',
                    ),
                    const SizedBox(width: 10),
                    InformationWidget(
                      icon: Icons.person,
                      label:
                          '${questionnaireProvider.targetRespondentController.text.isNotEmpty ? questionnaireProvider.targetRespondentController.text : '0'} Responden',
                    ),
                    const SizedBox(width: 10),
                    InformationWidget(
                      icon: Icons.date_range,
                      label: questionnaireProvider
                              .deadlineController.text.isNotEmpty
                          ? questionnaireProvider.deadlineController.text
                          : 'Tidak ditetapkan',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('Kriteria Responden:'),
                const SizedBox(height: 6),
                if (questionnaireProvider.isProfiling)
                  Wrap(
                    spacing: 4,
                    runSpacing: 10,
                    children:
                        questionnaireProvider.profiles!.entries.map((item) {
                      if (item.value == null || item.value == '') {
                        return const SizedBox.shrink();
                      }

                      var data = item.value;
                      final key = item.key;

                      if (key == 'college_id') {
                        final list = collegeProvider.colleges;
                        final idx =
                            list?.indexWhere((e) => e.id == item.value) ?? -1;
                        if (idx >= 0) data = list![idx].name ?? item.value;
                      } else if (key == 'department_id') {
                        final list = departmentProvider.departments;
                        final idx =
                            list?.indexWhere((e) => e.id == item.value) ?? -1;
                        if (idx >= 0) data = list![idx].name ?? item.value;
                      } else if (key == 'city_id') {
                        final list = cityProvider.cities;
                        final idx =
                            list?.indexWhere((e) => e.id == item.value) ?? -1;
                        if (idx >= 0) data = list![idx].name ?? item.value;
                      } else if (key == 'education_id') {
                        final list = educationProvider.educations;
                        final idx =
                            list?.indexWhere((e) => e.id == item.value) ?? -1;
                        if (idx >= 0) {
                          data = list![idx].educationName ?? item.value;
                        }
                      }

                      return GradientChipWidget(label: data?.toString() ?? '');
                    }).toList(),
                  ),
                if (!questionnaireProvider.isProfiling)
                  Text(
                    'Tidak ada kriteria responden yang ditetapkan.',
                    style: GoogleFonts.onest(
                      color: black1,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '*Akumulasi pengurangan poin dilakukan setiap kali kuesioner diisi',
                      style: GoogleFonts.robotoCondensed(
                          color: accentColor,
                          fontSize: 9,
                          fontStyle: FontStyle.italic),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.toll,
                          color: primaryColor,
                          size: 16,
                        ),
                        Text(
                          '$formattedHarga poin',
                          style: GoogleFonts.onest(
                            color: primaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 2),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: questionnaireProvider.isCreatingQuestionnaire
                        ? null
                        : () async {
                            try {
                              // Show loading indicator
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );

                              // Call the createQuestionnaire API
                              await questionnaireProvider.createQuestionnaire();

                              // Close loading dialog
                              Navigator.of(context).pop();

                              // Show success message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Kuesioner berhasil dipublikasikan!'),
                                  backgroundColor: Colors.green,
                                ),
                              );

                              // Navigate to finish page
                              NavigatorUtil.pushToDynamicPage(
                                context,
                                const FinishQuestionnairePage(),
                              );
                            } catch (e) {
                              // Close loading dialog if still open
                              Navigator.of(context).pop();

                              // Show error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Gagal mempublikasikan kuesioner: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: questionnaireProvider.isCreatingQuestionnaire
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Publikasikan',
                            style:
                                GoogleFonts.onest(fontSize: 16, color: white),
                          ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

class InformationWidget extends StatelessWidget {
  const InformationWidget({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 15,
        ),
        const SizedBox(width: 2),
        Text(
          label,
          style: GoogleFonts.onest(
            color: primaryColor,
            fontSize: 13,
          ),
        )
      ],
    );
  }
}
