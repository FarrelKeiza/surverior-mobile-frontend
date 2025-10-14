import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/navigation_bar_widget.dart';

class SuccessWithdrawPage extends StatelessWidget {
  const SuccessWithdrawPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/png/sand-timer.png"),
          SizedBox(
            height: defaultPadding,
          ),
          Text(
            "Selamat!",
            style: secondaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
          Text(
            "Poin telah di-withdraw dan sedang dalam proses pengiriman",
            style: secondaryTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(defaultPadding),
        color: white,
        child: CustomButtonWidget(
          text: "Tutup",
          isLoading: false,
          onPressed: () {
            NavigatorUtil.pushReplacementToDynamicPage(
              context,
              const NavigationBarWidget(),
            );
          },
        ),
      ),
    );
  }
}
