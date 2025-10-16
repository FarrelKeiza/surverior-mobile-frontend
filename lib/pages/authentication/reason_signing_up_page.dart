import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/pages/authentication/sign_in_page.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/background_gradient_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_question_auth_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_text_form_field_widget.dart';
import 'package:surverior_frontend_mobile/providers/authentication_provider.dart';

// class ReasonSigningUpPage extends StatefulWidget {
//   const ReasonSigningUpPage({super.key});
//
//   @override
//   State<ReasonSigningUpPage> createState() => _ReasonSigningUpPageState();
// }
//
// class _ReasonSigningUpPageState extends State<ReasonSigningUpPage> {
//   TextEditingController reasonController = TextEditingController();
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
//               Text(
//                 "SURVERIOR",
//                 style: primaryTextStyle.copyWith(
//                   fontWeight: bold,
//                   fontSize: 40,
//                   color: white,
//                 ),
//               ),
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
//                       "Daftar",
//                       style: primaryTextStyle.copyWith(
//                         fontSize: 20,
//                         fontWeight: bold,
//                       ),
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Alasan Mendaftar",
//                         style: primaryTextStyle,
//                       ),
//                     ),
//                     const Divider(),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     CustomTextFormFieldWidget(
//                       hintText: "Alasan...",
//                       controller: reasonController,
//                       isFilled: true,
//                       maxLines: 5,
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     CustomButtonWidget(
//                       text: "Daftar",
//                       color: secondaryColor,
//                       onPressed: () {
//                         NavigatorUtil.pushReplacementToDynamicPage(
//                           context,
//                           const SignInPage(),
//                         );
//                       },
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     const CustomQuestionAuthButtonWidget(
//                       question: "Sudah memiliki akun?",
//                       buttonText: "Masuk",
//                       page: SignInPage(),
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

class ReasonSigningUpPage extends HookWidget {
  const ReasonSigningUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController reasonController = useTextEditingController();

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
                        "Alasan Mendaftar",
                        style: primaryTextStyle,
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomTextFormFieldWidget(
                      hintText: "Alasan...",
                      controller: reasonController,
                      isFilled: true,
                      maxLines: 5,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomButtonWidget(
                      text: "Daftar",
                      color: secondaryColor,
                      onPressed: () async {
                        final reason = reasonController.text.trim();

                        final auth = Provider.of<AuthenticationProvider>(
                          context,
                          listen: false,
                        );
                        auth.setReasonSigningUp(reason: reason);

                        if (!(auth.signUpIsAcademic!)) {
                          await auth.finalSignUpNonAcademic();
                        } else {
                          await auth.finalSignUpAcademic();
                        }
                        await auth.createPin(context);
                        if (!context.mounted) return;
                        NavigatorUtil.pushReplacementToDynamicPage(
                          context,
                          const SignInPage(),
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
