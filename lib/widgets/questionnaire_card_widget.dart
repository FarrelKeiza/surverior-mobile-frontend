import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';

class QuestionnaireCardWidget extends StatelessWidget {
  const QuestionnaireCardWidget({
    super.key,
    this.isProgress = false,
    this.isOwned = false,
  });

  final bool isProgress, isOwned;

  @override
  Widget build(BuildContext context) {
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
                    "Judul Kuesioner",
                    style: secondaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          gradientWidgetColorMask(
                            Icon(isOwned
                                ? Icons.calendar_month_rounded
                                : Icons.person),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            isOwned ? "13 Juli 2025" : "Surveyor",
                            style: secondaryTextStyle,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Image.asset("assets/png/category.png"),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Kategori",
                            style: secondaryTextStyle,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Image.asset("assets/png/coins-2.png"),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "120 poin",
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
                          "Lorem ipsum dolor sit amet, consectetur adipiscing.",
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
