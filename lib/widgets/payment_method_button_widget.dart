import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/pages/witdrawal/confirm_withdraw_page.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/gradient_bordered_card_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodButtonWidget extends StatelessWidget {
  const PaymentMethodButtonWidget({
    super.key,
    required this.paymentMethod,
    required this.accountNumber,
    required this.paymentMethodLogoUrl,
    this.isSvg = false,
  });

  final String paymentMethod, accountNumber, paymentMethodLogoUrl;
  final bool isSvg;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigatorUtil.pushToDynamicPage(
          context,
          const ConfirmWithdrawPage(),
        );
      },
      child: GradientBorderedCardWidget(
        child: Row(
          children: [
            isSvg
                ? SvgPicture.network(
                    paymentMethodLogoUrl,
                    height: 10,
                    width: 10,
                  )
                : Image.network(
                    paymentMethodLogoUrl,
                    height: 20,
                    width: 20,
                  ),
            SizedBox(
              width: defaultPadding,
            ),
            Text(
              "$paymentMethod - $accountNumber",
              style: secondaryTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
