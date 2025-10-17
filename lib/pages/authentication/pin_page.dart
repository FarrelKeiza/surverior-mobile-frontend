import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/pages/authentication/sign_in_page.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/background_gradient_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_question_auth_button_widget.dart';
import 'package:surverior_frontend_mobile/providers/authentication_provider.dart';

// class PinPage extends StatefulWidget {
//   const PinPage({super.key});
//
//   @override
//   State<PinPage> createState() => _PinPageState();
// }
//
// class _PinPageState extends State<PinPage> {
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
//               SizedBox(
//                 height: defaultPadding,
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
//                     // Text(
//                     //   "Daftar",
//                     //   style: primaryTextStyle.copyWith(
//                     //     fontSize: 20,
//                     //     fontWeight: bold,
//                     //   ),
//                     // ),
//                     // SizedBox(
//                     //   height: defaultPadding,
//                     // ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "PIN Transaksi",
//                         style: primaryTextStyle,
//                       ),
//                     ),
//                     const Divider(),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     Pinput(
//                       length: 6,
//                       defaultPinTheme: PinTheme(
//                         width: 60,
//                         height: 60,
//                         decoration: BoxDecoration(
//                           color: white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     CustomButtonWidget(
//                       text: "Lanjut",
//                       color: secondaryColor,
//                       onPressed: () {
//                         NavigatorUtil.pushToReasonSigningUp(context);
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

class PinPage extends HookWidget {
  const PinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController pinController = useTextEditingController();

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
                    // Text(
                    //   "Daftar",
                    //   style: primaryTextStyle.copyWith(
                    //     fontSize: 20,
                    //     fontWeight: bold,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: defaultPadding,
                    // ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "PIN Transaksi",
                        style: primaryTextStyle,
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Pinput(
                      length: 6,
                      defaultPinTheme: PinTheme(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: pinController,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomButtonWidget(
                      text: "Lanjut",
                      color: secondaryColor,
                      onPressed: () async {
                        final pin = pinController.text.trim();
                        if (pin.length != 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Masukkan 6 digit PIN'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        final auth = Provider.of<AuthenticationProvider>(
                          context,
                          listen: false,
                        );

                        auth.pin = pin;

                        if (!context.mounted) return;
                        NavigatorUtil.pushToReasonSigningUp(context);
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
