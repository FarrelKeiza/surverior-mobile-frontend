import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/pages/authentication/forgot_password_page.dart';
import 'package:surverior_frontend_mobile/pages/authentication/sign_up_page.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/background_gradient_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_question_auth_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_text_form_field_widget.dart';
import 'package:surverior_frontend_mobile/widgets/navigation_bar_widget.dart';
import 'package:surverior_frontend_mobile/providers/authentication_provider.dart';

// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});
//
//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }
//
// class _SignInPageState extends State<SignInPage> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BackgroundGradientWidget(
//       child: SingleChildScrollView(
//         padding: EdgeInsets.all(defaultPadding),
//         physics: const BouncingScrollPhysics(),
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             minHeight: height(context) - (defaultPadding * 2),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset("assets/png/logo-white.png"),
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 width: double.maxFinite,
//                 decoration: BoxDecoration(
//                   color: primaryColor,
//                   borderRadius: BorderRadius.circular(defaultBorderRadius),
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Masuk",
//                       style: primaryTextStyle.copyWith(
//                         fontSize: 20,
//                         fontWeight: bold,
//                       ),
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     CustomTextFormFieldWidget(
//                       hintText: "Email instansi (akademisi)",
//                       controller: emailController,
//                       isFilled: true,
//                       prefixIcon: Icon(
//                         Icons.mail_outlined,
//                         color: black1,
//                       ),
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     CustomTextFormFieldWidget(
//                       hintText: "Kata Sandi",
//                       controller: passwordController,
//                       isFilled: true,
//                       // isEnabled: false,
//                       prefixIcon: Icon(
//                         Icons.lock_outlined,
//                         color: black1,
//                       ),
//                       suffixIcon: Icon(
//                         Icons.visibility_outlined,
//                         color: black1,
//                       ),
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     CustomButtonWidget(
//                       text: "Masuk",
//                       color: secondaryColor,
//                       onPressed: () {
//                         NavigatorUtil.pushReplacementToDynamicPage(
//                           context,
//                           const NavigationBarWidget(),
//                         );
//                       },
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     const CustomQuestionAuthButtonWidget(
//                       question: "Lupa kata sandi?",
//                       buttonText: "Setel Ulang",
//                       page: ForgotPasswordPage(),
//                       isRegularPush: false,
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     const CustomQuestionAuthButtonWidget(
//                       question: "Belum memiliki akun?",
//                       buttonText: "Daftar",
//                       page: SignUpPage(),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class SignInPage extends HookWidget {
  const SignInPage({super.key});

  Future<void> onLogin(BuildContext context, AuthenticationProvider auth,
      {required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Email dan kata sandi tidak boleh kosong")),
      );
      return;
    }

    try {
      final success = await auth.signIn(email, password);
      if (!context.mounted) return;
      if (success) {
        NavigatorUtil.pushReplacementToDynamicPage(
          context,
          const NavigationBarWidget(),
        );
      } else {
        final message = auth.authenticationModel?.metadata?.message ??
            "Gagal masuk. Periksa kredensial.";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();

    // listen to provider changes (rebuilds when isLoading or other fields update)
    final auth = context.watch<AuthenticationProvider>();

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
                    SizedBox(height: defaultPadding),
                    CustomTextFormFieldWidget(
                      hintText: "Email instansi (akademisi)",
                      controller: emailController,
                      isFilled: true,
                      prefixIcon: Icon(
                        Icons.mail_outlined,
                        color: black1,
                      ),
                    ),
                    SizedBox(height: defaultPadding),
                    CustomTextFormFieldWidget(
                      hintText: "Kata Sandi",
                      controller: passwordController,
                      isFilled: true,
                      isPasswordField: true,
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: black1,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility_outlined,
                        color: black1,
                      ),
                    ),
                    SizedBox(height: defaultPadding),

                    // Button - shows loading indicator when provider.isLoading is true
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: auth.isLoading
                            ? null
                            : () => onLogin(
                                  context,
                                  auth,
                                  email: emailController.text.trim(),
                                  password: passwordController.text,
                                ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                          ),
                        ),
                        child: auth.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : const Text("Masuk", style: TextStyle(color: Colors.white),),
                      ),
                    ),

                    SizedBox(height: defaultPadding),
                    const CustomQuestionAuthButtonWidget(
                      question: "Lupa kata sandi?",
                      buttonText: "Setel Ulang",
                      page: ForgotPasswordPage(),
                      isRegularPush: false,
                    ),
                    SizedBox(height: defaultPadding),
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
