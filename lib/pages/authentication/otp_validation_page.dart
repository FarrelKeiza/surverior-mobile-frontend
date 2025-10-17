import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/pages/authentication/sign_in_page.dart';
import 'package:surverior_frontend_mobile/providers/authentication_provider.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/background_gradient_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_question_auth_button_widget.dart';

class OtpValidationPage extends StatefulWidget {
  const OtpValidationPage({super.key});

  @override
  State<OtpValidationPage> createState() => _OtpValidationPageState();
}

class _OtpValidationPageState extends State<OtpValidationPage> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
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
                        "OTP",
                        style: primaryTextStyle,
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Consumer<AuthenticationProvider>(
                      builder: (context, authProvider, child) {
                        return Column(
                          children: [
                            // Display email that OTP was sent to
                            if (authProvider.signUpEmail != null) ...[
                              Text(
                                "Kode OTP telah dikirim ke:",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 12,
                                  color: Colors.grey[300],
                                ),
                              ),
                              Text(
                                authProvider.signUpEmail!,
                                style: primaryTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: defaultPadding),
                            ],
                            // Display error if any
                            if (authProvider.otpError.isNotEmpty) ...[
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.red[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  authProvider.otpError,
                                  style: TextStyle(
                                    color: Colors.red[800],
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(height: defaultPadding),
                            ],
                            Pinput(
                              controller: _otpController,
                              length: 6,
                              onChanged: (value) {
                                if (authProvider.otpError.isNotEmpty) {
                                  authProvider.clearOtpError();
                                }
                              },
                              defaultPinTheme: PinTheme(
                                width: 60,
                                height: 60,
                                textStyle: secondaryTextStyle,
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: authProvider.otpError.isNotEmpty
                                        ? Colors.red
                                        : Colors.grey[300]!,
                                  ),
                                ),
                              ),
                              focusedPinTheme: PinTheme(
                                width: 60,
                                height: 60,
                                textStyle: secondaryTextStyle,
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: secondaryColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Consumer<AuthenticationProvider>(
                      builder: (context, authProvider, child) {
                        return Column(
                          children: [
                            CustomButtonWidget(
                              text: authProvider.isLoading
                                  ? "Memverifikasi..."
                                  : "Verifikasi OTP",
                              color: secondaryColor,
                              onPressed: authProvider.isLoading
                                  ? () {}
                                  : () async {
                                      // Validate OTP input
                                      if (_otpController.text.length != 6) {
                                        authProvider.setOtpError(
                                            "Kode OTP harus 6 digit");
                                        return;
                                      }

                                      if (authProvider.signUpEmail == null) {
                                        authProvider.setOtpError(
                                            "Email tidak ditemukan. Silakan kembali ke halaman pendaftaran.");
                                        return;
                                      }

                                      try {
                                        // Verify OTP
                                        bool otpValid =
                                            await authProvider.verifyOtp(
                                          authProvider.signUpEmail!,
                                          _otpController.text,
                                        );

                                        if (otpValid) {
                                          // Navigate to information page
                                          if (context.mounted) {
                                            NavigatorUtil.pushToInformationPage(
                                              context,
                                              1,
                                            );
                                          }
                                        } else {
                                          authProvider.setOtpError(authProvider
                                                  .authenticationModel
                                                  ?.metadata
                                                  ?.message ??
                                              "Kode OTP tidak valid atau sudah kadaluarsa");
                                        }
                                      } catch (e) {
                                        authProvider.setOtpError(
                                            "Terjadi kesalahan: ${e.toString()}");
                                      }
                                    },
                            ),
                            SizedBox(height: defaultPadding),
                            // Resend OTP button
                            TextButton(
                              onPressed: authProvider.isLoading
                                  ? null
                                  : () async {
                                      if (authProvider.signUpEmail != null) {
                                        try {
                                          bool otpSent =
                                              await authProvider.sendOtp(
                                            authProvider.signUpEmail!,
                                          );

                                          if (otpSent && context.mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Kode OTP baru telah dikirim"),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                            // Clear previous OTP input
                                            _otpController.clear();
                                            authProvider.clearOtpError();
                                          } else if (context.mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(authProvider
                                                        .otpModel
                                                        ?.metadata
                                                        ?.message ??
                                                    "Gagal mengirim ulang OTP"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Error: ${e.toString()}"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    },
                              child: Text(
                                "Kirim ulang OTP",
                                style: primaryTextStyle.copyWith(
                                  color: authProvider.isLoading
                                      ? Colors.grey
                                      : white,
                                  decoration: TextDecoration.underline,
                                  decorationColor: white,
                                ),
                              ),
                            ),
                          ],
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
