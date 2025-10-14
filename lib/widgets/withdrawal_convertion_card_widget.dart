import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/pages/witdrawal/withdraw_page.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/circular_checbox_widet.dart';

class WithdrawalConvertionCardWidget extends StatelessWidget {
  const WithdrawalConvertionCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              gradient: primaryGradient,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(defaultPadding),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Poin",
                            style: primaryTextStyle,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "assets/png/poins-2.png",
                                height: 20,
                                width: 20,
                              ),
                              Text(
                                "8034",
                                style: primaryTextStyle.copyWith(
                                  fontWeight: bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Icon(
                        Icons.compare_arrows_rounded,
                        color: white,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Nilai Tukar",
                            style: primaryTextStyle,
                          ),
                          Text(
                            "Rp1.000.000",
                            style: primaryTextStyle.copyWith(
                              fontWeight: bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Slider(
                  padding: EdgeInsets.zero,
                  thumbColor: white,
                  activeColor: white,
                  value: 0.6,
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                CircularChecboxWidet(
                  size: 20,
                  text: RichText(
                    text: TextSpan(
                      text: "Saya telah membaca dan menyetujui ",
                      style: primaryTextStyle.copyWith(
                        color: white,
                      ),
                      children: [
                        WidgetSpan(
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              "Syarat dan Ketentuan",
                              style: primaryTextStyle.copyWith(
                                color: white,
                                decoration: TextDecoration.underline,
                                decorationColor: white,
                              ),
                            ),
                          ),
                        ),
                        TextSpan(
                          text: " yang berlaku.",
                          style: primaryTextStyle.copyWith(
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  value: false,
                  onTap: (value) {},
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              NavigatorUtil.pushToDynamicPage(
                context,
                const WithdrawPage(),
              );
            },
            child: Container(
              padding: EdgeInsets.all(defaultPadding),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(defaultBorderRadius),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 20,
                      spreadRadius: 2,
                      color: secondaryColor.withValues(alpha: 0.5),
                    ),
                  ]),
              child: Center(
                child: gradientWidgetColorMask(
                  Text(
                    "Withdraw",
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
