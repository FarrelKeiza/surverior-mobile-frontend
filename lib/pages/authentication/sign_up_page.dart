import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/pages/authentication/sign_in_page.dart';
import 'package:surverior_frontend_mobile/providers/authentication_provider.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/background_gradient_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_question_auth_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_text_form_field_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

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
                      "Daftar",
                      style: primaryTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Informasi Akun",
                        style: primaryTextStyle,
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomTextFormFieldWidget(
                      hintText: "Alamat Email",
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
                      hintText: "Username",
                      controller: usernameController,
                      isFilled: true,
                      prefixIcon: Icon(
                        Icons.person_outlined,
                        color: black1,
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Consumer<AuthenticationProvider>(
                      builder: (context, authenticationProvider, child) {
                        return CustomTextFormFieldWidget(
                          hintText: "Kata Sandi",
                          controller: passwordController,
                          isFilled: true,
                          isEnabled: true,
                          isObscureText: authenticationProvider.isObsecure,
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            color: black1,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              authenticationProvider.checkObsecure();
                            },
                            child: authenticationProvider.isObsecure
                                ? Icon(
                                    Icons.visibility_outlined,
                                    color: black1,
                                  )
                                : Icon(
                                    Icons.visibility_off_outlined,
                                    color: black1,
                                  ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Consumer<AuthenticationProvider>(
                      builder: (context, authenticationProvider, child) {
                        return CustomTextFormFieldWidget(
                          hintText: "Konfirmasi Kata Sandi",
                          controller: passwordConfirmationController,
                          isObscureText:
                              authenticationProvider.isObsecureConfirmation,
                          isFilled: true,
                          isEnabled: true,
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            color: black1,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              authenticationProvider
                                  .checkObsecureConfirmation();
                            },
                            child: authenticationProvider.isObsecureConfirmation
                                ? Icon(
                                    Icons.visibility_outlined,
                                    color: black1,
                                  )
                                : Icon(
                                    Icons.visibility_off_outlined,
                                    color: black1,
                                  ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Consumer<AuthenticationProvider>(
                      builder: (context, authProvider, child) {
                        return CustomButtonWidget(
                          text:
                              authProvider.isLoading ? "Loading..." : "Lanjut",
                          color: secondaryColor,
                          onPressed: authProvider.isLoading
                              ? () {}
                              : () async {
                                  // Validate form
                                  if (emailController.text.isEmpty ||
                                      usernameController.text.isEmpty ||
                                      passwordController.text.isEmpty ||
                                      passwordConfirmationController
                                          .text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Semua field harus diisi"),
                                      ),
                                    );
                                    return;
                                  }

                                  if (passwordController.text !=
                                      passwordConfirmationController.text) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Password tidak sama"),
                                      ),
                                    );
                                    return;
                                  }

                                  try {
                                    // Save account info to provider
                                    authProvider.setAccountInfo(
                                      name: usernameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text,
                                      passwordConfirmation:
                                          passwordConfirmationController.text,
                                    );

                                    // Send OTP
                                    bool otpSent = await authProvider
                                        .sendOtp(emailController.text.trim());

                                    if (otpSent) {
                                      // Navigate to OTP validation
                                      if (context.mounted) {
                                        NavigatorUtil.pushToOtpValidation(
                                            context);
                                      }
                                    } else {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(authProvider.otpModel
                                                    ?.metadata?.message ??
                                                "Gagal mengirim OTP. Silakan coba lagi."),
                                          ),
                                        );
                                      }
                                    }
                                  } catch (e) {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text("Error: ${e.toString()}"),
                                        ),
                                      );
                                    }
                                  }
                                },
                        );
                      },
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    const CustomQuestionAuthButtonWidget(
                      question: "Sudah memiliki akun?",
                      buttonText: "Masuk",
                      page: SignInPage(),
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
