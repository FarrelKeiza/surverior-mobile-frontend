import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/button_back_app_bar_widget.dart';
import 'package:surverior_frontend_mobile/widgets/voucher_card_widget.dart';

class OwnedVoucherPage extends StatelessWidget {
  const OwnedVoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title: const ButtonBackAppBarWidget(title: "Voucher Saya"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return const VoucherCardWidget(
                isOwned: true,
              );
            },
          ),
        ),
      ),
    );
  }
}
