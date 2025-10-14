import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/pages/authentication/sign_up_page.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/background_gradient_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_question_auth_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_text_form_field_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BackgroundGradientWidget(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: height(context) - (defaultPadding * 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SURVERIOR",
                style: primaryTextStyle.copyWith(
                  fontWeight: bold,
                  fontSize: 40,
                  color: white,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
                child: Column(
                  children: [
                    Text(
                      "Lupa Kata Sandi",
                      style: primaryTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomTextFormFieldWidget(
                      hintText: "Email instansi (akademisi)",
                      controller: emailController,
                      isFilled: true,
                      prefixIcon: Icon(
                        Icons.mail_rounded,
                        color: black1,
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomButtonWidget(
                      text: "Minta OTP",
                      color: secondaryColor,
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    const CustomQuestionAuthButtonWidget(
                      question: "Belum memiliki akun?",
                      buttonText: "Daftar",
                      page: SignUpPage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
