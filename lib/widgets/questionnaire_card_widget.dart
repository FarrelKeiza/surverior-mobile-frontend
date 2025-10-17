import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/models/questionnaire_model.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';

class QuestionnaireCardWidget extends StatelessWidget {
  const QuestionnaireCardWidget({
    super.key,
    this.questionnaire,
    this.isProgress = false,
    this.isOwned = false,
  });

  final QuestionnaireModel? questionnaire;
  final bool isProgress, isOwned;

  @override
  Widget build(BuildContext context) {
    // Helper function to format currency
    String formatCurrency(double? value) {
      if (value == null) return 'Gratis';
      String formatted = value.toStringAsFixed(0);
      String result = '';
      int count = 0;

      for (int i = formatted.length - 1; i >= 0; i--) {
        if (count > 0 && count % 3 == 0) {
          result = '.$result';
        }
        result = formatted[i] + result;
        count++;
      }

      return result;
    }

    // Helper function to format date
    String formatDate(String? dateString) {
      if (dateString == null) return 'Tidak ada deadline';

      try {
        DateTime date = DateTime.parse(dateString);
        List<String> months = [
          '',
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'Mei',
          'Jun',
          'Jul',
          'Agu',
          'Sep',
          'Okt',
          'Nov',
          'Des'
        ];

        return '${date.day} ${months[date.month]} ${date.year}';
      } catch (e) {
        return dateString;
      }
    }

    return Padding(
      padding: EdgeInsets.only(bottom: defaultPadding),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              gradient: primaryGradient,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            child: Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(defaultBorderRadius - 3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    questionnaire?.title ?? "Judul Kuesioner",
                    style: secondaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      // Creator or deadline info
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            gradientWidgetColorMask(
                              Icon(isOwned
                                  ? Icons.calendar_month_rounded
                                  : Icons.person),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                isOwned
                                    ? formatDate(questionnaire?.deadline)
                                    : questionnaire?.user?.name ?? "Surveyor",
                                style: secondaryTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // Category
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Image.asset("assets/png/category.png"),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                questionnaire?.category?.name ?? "Kategori",
                                style: secondaryTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // Reward
                      Row(
                        children: [
                          Image.asset("assets/png/coins-2.png"),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            formatCurrency(questionnaire?.reward),
                            style: secondaryTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          questionnaire?.description ??
                              "Deskripsi kuesioner tidak tersedia",
                          style: secondaryTextStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomButtonWidget(
                        text: isOwned ? "Lihat" : "Mulai",
                        isGradient: true,
                        isAutoSize: false,
                        height: 45,
                        width: 100,
                        onPressed: () {},
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isProgress,
            child: Positioned(
              right: 0,
              top: 20,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(defaultBorderRadius),
                  ),
                ),
                child: Text(
                  "Progres",
                  style: primaryTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
