import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/button_back_app_bar_widget.dart';
import 'package:surverior_frontend_mobile/widgets/payment_method_button_widget.dart';

class WithdrawPage extends StatelessWidget {
  const WithdrawPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title: const ButtonBackAppBarWidget(title: "Withdraw"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          physics:  const BouncingScrollPhysics(),
          child: const Column(
            children: [
              PaymentMethodButtonWidget(
                paymentMethod: "BRI",
                accountNumber: "15**-*****-****",
                paymentMethodLogoUrl:
                    "https://bri.co.id/o/bri-corporate-theme/images/bri-logo.png",
              ),
              PaymentMethodButtonWidget(
                isSvg: true,
                paymentMethod: "BCA",
                accountNumber: "233*******",
                paymentMethodLogoUrl:
                    "https://www.bca.co.id/-/media/Feature/Header/Header-Logo/logo-bca.svg?v=1",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
