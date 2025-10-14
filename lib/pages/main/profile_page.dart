import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/pages/profile/edit_profile_page.dart';
import 'package:surverior_frontend_mobile/pages/profile/owned_questionnaire_page.dart';
import 'package:surverior_frontend_mobile/pages/profile/owned_voucher_page.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_text_form_field_labelled_widget.dart';
import 'package:surverior_frontend_mobile/widgets/gradient_bordered_card_widget.dart';
import 'package:surverior_frontend_mobile/widgets/weekly_login_card_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController redeemCodeController = TextEditingController();

  showRedeemCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.center,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    gradient: primaryGradient,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(defaultBorderRadius),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Redeem Code",
                      style: primaryTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      CustomTextFormFieldLabelledWidget(
                        label: "Redeem Code",
                        showLabel: false,
                        controller: redeemCodeController,
                      ),
                      CustomButtonWidget(
                        text: "Redeem",
                        isGradient: true,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: white,
                    backgroundImage: const AssetImage("assets/jpeg/ikis.jpeg"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Krisna Purnama",
                          style: secondaryTextStyle.copyWith(
                            fontWeight: bold,
                          ),
                        ),
                        Text(
                          "Jurusan Teknik Komputer dan Informatika",
                          style: secondaryTextStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset("assets/png/bri.png"),
                            Image.asset("assets/png/bca.png"),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 3,
                            bottom: 3,
                            right: 0,
                            left: 5,
                          ),
                          decoration: BoxDecoration(
                            gradient: primaryGradient,
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sumber Dana",
                                style: primaryTextStyle.copyWith(fontSize: 12),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: white,
                                size: 18,
                              ),
                            ],
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
              const WeeklyLoginCardWidget(),
              SizedBox(
                height: defaultPadding,
              ),
              GestureDetector(
                onTap: () {
                  NavigatorUtil.pushToDynamicPage(
                    context,
                    const EditProfilePage(),
                  );
                },
                child: GradientBorderedCardWidget(
                  padding: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Profil",
                        style: primaryTextStyle.copyWith(
                          color: primaryColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: primaryColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  NavigatorUtil.pushToDynamicPage(
                    context,
                    const OwnedVoucherPage(),
                  );
                },
                child: GradientBorderedCardWidget(
                  padding: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Voucher Saya",
                        style: primaryTextStyle.copyWith(
                          color: primaryColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: primaryColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  NavigatorUtil.pushToDynamicPage(
                    context,
                    const OwnedQuestionnairePage(),
                  );
                },
                child: GradientBorderedCardWidget(
                  padding: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Kuesioner Saya",
                        style: primaryTextStyle.copyWith(
                          color: primaryColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: primaryColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showRedeemCodeDialog(context);
                },
                child: GradientBorderedCardWidget(
                  padding: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Redeem Code",
                        style: primaryTextStyle.copyWith(
                          color: primaryColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: primaryColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              GradientBorderedCardWidget(
                padding: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ulasan Pengguna",
                      style: primaryTextStyle.copyWith(
                        color: primaryColor,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: primaryColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  border: Border.all(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
                child: Text(
                  "Keluar",
                  style: primaryTextStyle.copyWith(
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/png/whatsapp.png"),
                  Image.asset("assets/png/gmail.png"),
                  Image.asset("assets/png/instagram.png"),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Kontak Kami",
                style: secondaryTextStyle.copyWith(
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(
                height: 85,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
