import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/filter_dropdown_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/voucher_card_widget.dart';
import 'package:surverior_frontend_mobile/widgets/withdrawal_convertion_card_widget.dart';

class WithdrawalPage extends StatelessWidget {
  const WithdrawalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title: gradientWidgetColorMask(
          Text(
            "Withdrawal",
            style: primaryTextStyle.copyWith(
              fontWeight: bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const WithdrawalConvertionCardWidget(),
              SizedBox(
                height: defaultPadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 5,
                    child: Text(
                      "atau tukarkan dengan voucher",
                      style: secondaryTextStyle,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: FilterDropdownButtonWidget(
                      hintText: "Semua Merchant",
                      items: const [],
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultPadding,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const VoucherCardWidget();
                },
              ),
              const SizedBox(
                height: 65,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
