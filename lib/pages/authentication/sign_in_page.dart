import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/pages/authentication/forgot_password_page.dart';
import 'package:surverior_frontend_mobile/pages/authentication/sign_up_page.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/background_gradient_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_question_auth_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_text_form_field_widget.dart';
import 'package:surverior_frontend_mobile/widgets/navigation_bar_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              Image.asset("assets/png/logo-white.png"),
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
                      "Masuk",
                      style: primaryTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomTextFormFieldWidget(
                      hintText: "Email instansi (akademisi)",
                      controller: emailController,
                      isFilled: true,
                      prefixIcon: Icon(
                        Icons.mail_outlined,
                        color: black1,
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomTextFormFieldWidget(
                      hintText: "Kata Sandi",
                      controller: passwordController,
                      isFilled: true,
                      isEnabled: false,
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: black1,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility_outlined,
                        color: black1,
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomButtonWidget(
                      text: "Masuk",
                      color: secondaryColor,
                      onPressed: () {
                        NavigatorUtil.pushReplacementToDynamicPage(
                          context,
                          const NavigationBarWidget(),
                        );
                      },
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    const CustomQuestionAuthButtonWidget(
                      question: "Lupa kata sandi?",
                      buttonText: "Setel Ulang",
                      page: ForgotPasswordPage(),
                      isRegularPush: false,
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
