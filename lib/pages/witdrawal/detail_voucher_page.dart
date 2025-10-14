import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/button_back_app_bar_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';

class DetailVoucherPage extends StatelessWidget {
  const DetailVoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title: const ButtonBackAppBarWidget(title: "Detail Voucher"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/png/surverior-circular.png",
                    ),
                    radius: 35,
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
                            fontWeight: semiBold,
                          ),
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Harga: 10.000 Poin",
                  style: primaryTextStyle.copyWith(
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(defaultBorderRadius),
                child: Image.asset("assets/png/polban-gd-h.png"),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Deskripsi Voucher",
                  style: secondaryTextStyle.copyWith(
                    fontWeight: bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus. Nullam quis imperdiet augue. Vestibulum auctor ornare leo, non suscipit magna interdum eu. Curabitur pellentesque nibh nibh, at maximus ante fermentum sit amet. Pellentesque commodo lacus at sodales sodales. Quisque sagittis orci ut diam condimentum, vel euismod erat placerat. In iaculis arcu eros, eget tempus orci facilisis id.",
                  style: secondaryTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(defaultPadding),
        color: white,
        child: CustomButtonWidget(
          text: "Tukar",
          isGradient: true,
          isLoading: false,
          onPressed: () {},
        ),
      ),
    );
  }
}
