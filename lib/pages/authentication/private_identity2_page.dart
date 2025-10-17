import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/pages/authentication/sign_in_page.dart';
import 'package:surverior_frontend_mobile/providers/authentication_provider.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/background_gradient_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_dropdown_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_question_auth_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_text_form_field_widget.dart';
import 'package:surverior_frontend_mobile/providers/education_provider.dart';

// class PrivateIdentity2Page extends StatefulWidget {
//   const PrivateIdentity2Page({super.key});
//
//   @override
//   State<PrivateIdentity2Page> createState() => _PrivateIdentity2PageState();
// }
//
// class _PrivateIdentity2PageState extends State<PrivateIdentity2Page> {
//   TextEditingController domicileController = TextEditingController();
//   String? marriedStatus;
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
//                         "Identitas Pribadi",
//                         style: primaryTextStyle,
//                       ),
//                     ),
//                     const Divider(),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     CustomTextFormFieldWidget(
//                       hintText: "Domisili",
//                       controller: domicileController,
//                       isFilled: true,
//                       prefixIcon: Icon(
//                         Icons.location_pin,
//                         color: black1,
//                       ),
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     CustomDropdownButtonWidget(
//                       hintText: "Status Pernikahan",
//                       value: marriedStatus,
//                       onChanged: (value) {
//                         setState(() {
//                           marriedStatus = value;
//                         });
//                       },
//                       items: [
//                         DropdownMenuItem(
//                           value: "Laki-laki",
//                           child: Text(
//                             "Laki-laki",
//                             style: secondaryTextStyle,
//                           ),
//                         ),
//                         DropdownMenuItem(
//                           value: "Perempuan",
//                           child: Text(
//                             "Perempuan",
//                             style: secondaryTextStyle,
//                           ),
//                         ),
//                       ],
//                       prefixIcon: Image.asset(
//                         "assets/png/ring.png",
//                         height: 20,
//                         width: 20,
//                       ),
//                       suffixIcon: Icon(
//                         Icons.keyboard_arrow_down_outlined,
//                         color: black1,
//                       ),
//                       isFilled: true,
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     CustomDropdownButtonWidget(
//                       hintText: "Pendidikan Terakhir",
//                       value: marriedStatus,
//                       onChanged: (value) {
//                         setState(() {
//                           marriedStatus = value;
//                         });
//                       },
//                       items: [
//                         DropdownMenuItem(
//                           value: "Laki-laki",
//                           child: Text(
//                             "Laki-laki",
//                             style: secondaryTextStyle,
//                           ),
//                         ),
//                         DropdownMenuItem(
//                           value: "Perempuan",
//                           child: Text(
//                             "Perempuan",
//                             style: secondaryTextStyle,
//                           ),
//                         ),
//                       ],
//                       prefixIcon: Icon(
//                         Icons.school_outlined,
//                         color: black1,
//                       ),
//                       suffixIcon: Icon(
//                         Icons.keyboard_arrow_down_outlined,
//                         color: black1,
//                       ),
//                       isFilled: true,
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Opsional Jika Anda Merupakan Akademisi",
//                         style: primaryTextStyle.copyWith(
//                           decoration: TextDecoration.underline,
//                           decorationColor: white,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           flex: 5,
//                           child: CustomButtonWidget(
//                             text: "Mahasiswa",
//                             color: secondaryColor,
//                             onPressed: () {
//                               NavigatorUtil.pushToAcademicIdentity(
//                                 context,
//                                 1,
//                               );
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           width: defaultPadding,
//                         ),
//                         Expanded(
//                           flex: 5,
//                           child: CustomButtonWidget(
//                             text: "Dosen",
//                             color: secondaryColor,
//                             onPressed: () {
//                               NavigatorUtil.pushToAcademicIdentity(
//                                 context,
//                                 2,
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     CustomButtonWidget(
//                       text: "Lanjut",
//                       color: secondaryColor,
//                       onPressed: () {
//                         NavigatorUtil.pushToInformationPage(
//                           context,
//                           2,
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

final List<Map<String, String>> maritalOptions = [
  {'value': 'unmarried', 'label': 'Belum Menikah'},
  {'value': 'married', 'label': 'Menikah'},
  {'value': 'divorced', 'label': 'Cerai Hidup'},
  {'value': 'divorced_die', 'label': 'Cerai Mati'},
];

class PrivateIdentity2Page extends HookWidget {
  const PrivateIdentity2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final educationProvider = Provider.of<EducationProvider>(context);
    final educationProviderFetch =
        Provider.of<EducationProvider>(context, listen: false);
    useMemoized(() => educationProviderFetch.fetchEducations(),
        [educationProviderFetch]);
    final educations = educationProvider.educations ?? [];

    final TextEditingController domicileController = useTextEditingController();
    String? marriedStatus;
    String? educationStatus;

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
                        "Identitas Pribadi",
                        style: primaryTextStyle,
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomTextFormFieldWidget(
                      hintText: "Domisili",
                      controller: domicileController,
                      isFilled: true,
                      prefixIcon: Icon(
                        Icons.location_pin,
                        color: black1,
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomDropdownButtonWidget(
                      hintText: "Status Pernikahan",
                      value: marriedStatus,
                      onChanged: (value) {
                        marriedStatus = value;
                      },
                      items: maritalOptions
                          .map((e) => DropdownMenuItem<String>(
                                value: e['value']!,
                                child: Text(
                                  e['label'] ?? e['value']!,
                                  style: secondaryTextStyle,
                                ),
                              ))
                          .toList(),
                      prefixIcon: Image.asset(
                        "assets/png/ring.png",
                        height: 20,
                        width: 20,
                      ),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: black1,
                      ),
                      isFilled: true,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomDropdownButtonWidget(
                      hintText: "Pendidikan Terakhir",
                      value: educationStatus,
                      onChanged: (value) {
                        educationStatus = value;
                      },
                      items: educations
                          .map((e) => DropdownMenuItem<String>(
                                value: e.id,
                                child: Text(e.educationName ?? ""),
                              ))
                          .toList(),
                      prefixIcon: Icon(
                        Icons.school_outlined,
                        color: black1,
                      ),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: black1,
                      ),
                      isFilled: true,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Opsional Jika Anda Merupakan Akademisi",
                        style: primaryTextStyle.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: CustomButtonWidget(
                            text: "Mahasiswa",
                            color: secondaryColor,
                            onPressed: () {
                              final domicile = domicileController.text.trim();
                              if (domicile.isEmpty ||
                                  marriedStatus == null ||
                                  educationStatus == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Lengkapi semua field terlebih dahulu')),
                                );
                                return;
                              }

                              final auth = Provider.of<AuthenticationProvider>(
                                  context,
                                  listen: false);
                              auth.setPersonalInfo2(
                                domicile: domicile,
                                marriedStatus: marriedStatus!,
                                lastEducation: educationStatus!,
                                isAcademic: true,
                              );

                              NavigatorUtil.pushToAcademicIdentity(
                                context,
                                1,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: defaultPadding,
                        ),
                        Expanded(
                          flex: 5,
                          child: CustomButtonWidget(
                            text: "Dosen",
                            color: secondaryColor,
                            onPressed: () {
                              final domicile = domicileController.text.trim();

                              if (domicile.isEmpty ||
                                  marriedStatus == null ||
                                  educationStatus == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Lengkapi semua field terlebih dahulu')),
                                );
                                return;
                              }

                              final auth = Provider.of<AuthenticationProvider>(
                                  context,
                                  listen: false);
                              auth.setPersonalInfo2(
                                domicile: domicile,
                                marriedStatus: marriedStatus!,
                                lastEducation: educationStatus!,
                                isAcademic: true,
                              );

                              NavigatorUtil.pushToAcademicIdentity(
                                context,
                                2,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomButtonWidget(
                      text: "Lanjut",
                      color: secondaryColor,
                      onPressed: () {
                        final domicile = domicileController.text.trim();

                        if (domicile.isEmpty ||
                            marriedStatus == null ||
                            educationStatus == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Lengkapi semua field terlebih dahulu')),
                          );
                          return;
                        }

                        final auth = Provider.of<AuthenticationProvider>(
                            context,
                            listen: false);
                        auth.setPersonalInfo2(
                          domicile: domicile,
                          marriedStatus: marriedStatus!,
                          lastEducation: educationStatus!,
                          isAcademic: false,
                        );

                        NavigatorUtil.pushToInformationPage(
                          context,
                          2,
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
