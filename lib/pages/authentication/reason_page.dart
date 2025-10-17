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

class ReasonPage extends StatefulWidget {
  const ReasonPage({super.key});

  @override
  State<ReasonPage> createState() => _ReasonPageState();
}

class _ReasonPageState extends State<ReasonPage> {
  TextEditingController reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load existing reason if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider =
          Provider.of<AuthenticationProvider>(context, listen: false);
      if (authProvider.signUpReason != null &&
          authProvider.signUpReason!.isNotEmpty) {
        reasonController.text = authProvider.signUpReason!;
      }
    });
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

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
              SizedBox(
                height: defaultPadding,
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
                        "Alasan Bergabung",
                        style: primaryTextStyle,
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Text(
                      "Ceritakan alasan Anda ingin bergabung dengan platform Surverior",
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        color: Colors.grey[300],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomTextFormFieldWidget(
                      hintText: "Tulis alasan Anda...",
                      controller: reasonController,
                      isFilled: true,
                      maxLines: 5,
                      prefixIcon: Icon(
                        Icons.edit_note_outlined,
                        color: black1,
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Consumer<AuthenticationProvider>(
                      builder: (context, authProvider, child) {
                        return CustomButtonWidget(
                          text: authProvider.isLoading
                              ? "Mendaftar..."
                              : "Selesai Daftar",
                          color: secondaryColor,
                          onPressed: authProvider.isLoading
                              ? () {}
                              : () async {
                                  // Validate reason
                                  if (reasonController.text.trim().isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Alasan bergabung harus diisi"),
                                      ),
                                    );
                                    return;
                                  }

                                  if (reasonController.text.trim().length <
                                      10) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Alasan bergabung minimal 10 karakter"),
                                      ),
                                    );
                                    return;
                                  }

                                  try {
                                    // Save reason to provider
                                    authProvider.setReason(
                                        reasonController.text.trim());

                                    // Perform final signup (non-academic)
                                    bool signupSuccess =
                                        await authProvider.performFinalSignUp();

                                    if (signupSuccess && context.mounted) {
                                      // Show success message
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Pendaftaran berhasil!"),
                                          backgroundColor: Colors.green,
                                        ),
                                      );

                                      // Clear signup data
                                      authProvider.clearSignUpData();

                                      // Navigate to success page or main app
                                      NavigatorUtil.pushToInformationPage(
                                        context,
                                        2,
                                      );
                                    } else if (context.mounted) {
                                      // Show error message
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(authProvider
                                                  .authenticationModel
                                                  ?.metadata
                                                  ?.message ??
                                              "Pendaftaran gagal. Silakan coba lagi."),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text("Error: ${e.toString()}"),
                                          backgroundColor: Colors.red,
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
