import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/pages/witdrawal/detail_voucher_page.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/gradient_bordered_card_widget.dart';

class VoucherCardWidget extends StatelessWidget {
  const VoucherCardWidget({
    super.key,
    this.isOwned = false,
  });

  final bool isOwned;

  @override
  Widget build(BuildContext context) {
    return GradientBorderedCardWidget(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/png/surverior-circular.png",
                    ),
                    radius: 35,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/png/poins-3.png",
                      ),
                      Text(
                        "10.000",
                        style: secondaryTextStyle.copyWith(
                          color: primaryColor,
                          fontWeight: bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                width: defaultPadding,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Voucher",
                      style: secondaryTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Nama Merchant",
                      style: secondaryTextStyle.copyWith(
                        fontWeight: bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing.",
                      style: secondaryTextStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: defaultPadding,
          ),
          CustomButtonWidget(
            text: isOwned ? "Lihat Detail" : "Tukar",
            isGradient: true,
            isLoading: false,
            onPressed: () {
              NavigatorUtil.pushToDynamicPage(
                context,
                const DetailVoucherPage(),
              );
            },
          ),
        ],
      ),
    );
  }
}
