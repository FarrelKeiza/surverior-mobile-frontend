import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:surverior_frontend_mobile/pages/witdrawal/success_withdraw_page.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/button_back_app_bar_widget.dart';

class ConfirmWithdrawPage extends StatelessWidget {
  const ConfirmWithdrawPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title: const ButtonBackAppBarWidget(title: "Konfirmasi Withdraw"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Konfimasi PIN Transaksi",
                    style: primaryTextStyle,
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: defaultPadding,
                ),
                Pinput(
                  length: 6,
                  defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onSubmitted: (value) {
                    NavigatorUtil.pushReplacementToDynamicPage(
                      context,
                      const SuccessWithdrawPage(),
                    );
                  },
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Lupa PIN?",
                    style: primaryTextStyle.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
