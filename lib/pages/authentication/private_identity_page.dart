import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/pages/authentication/sign_in_page.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/background_gradient_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_dropdown_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_question_auth_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_text_form_field_widget.dart';

class PrivateIdentityPage extends StatefulWidget {
  const PrivateIdentityPage({super.key});

  @override
  State<PrivateIdentityPage> createState() => _PrivateIdentityPageState();
}

class _PrivateIdentityPageState extends State<PrivateIdentityPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  String? selectedGender;

  void datePicker() async {
    var pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        birthDateController.text =
            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
    }
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
                        "Identitas Pribadi",
                        style: primaryTextStyle,
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomTextFormFieldWidget(
                      hintText: "Nama Lengkap",
                      controller: fullNameController,
                      isFilled: true,
                      prefixIcon: Icon(
                        Icons.person_outlined,
                        color: black1,
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomTextFormFieldWidget(
                      hintText: "Nomor Induk Kependudukan",
                      controller: fullNameController,
                      isFilled: true,
                      prefixIcon: Icon(
                        Icons.contact_mail_outlined,
                        color: black1,
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    GestureDetector(
                      onTap: () {
                        datePicker();
                      },
                      child: CustomTextFormFieldWidget(
                        hintText: "Tanggal Lahir",
                        controller: birthDateController,
                        isFilled: true,
                        isEnabled: false,
                        prefixIcon: Icon(
                          Icons.calendar_month_outlined,
                          color: black1,
                        ),
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: black1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomDropdownButtonWidget(
                      hintText: "Jenis Kelamin",
                      value: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: "Laki-laki",
                          child: Text(
                            "Laki-laki",
                            style: secondaryTextStyle,
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Perempuan",
                          child: Text(
                            "Perempuan",
                            style: secondaryTextStyle,
                          ),
                        ),
                      ],
                      prefixIcon: Image.asset(
                        "assets/png/gender.png",
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
                    CustomButtonWidget(
                      text: "Lanjut",
                      color: secondaryColor,
                      onPressed: () {
                        NavigatorUtil.pushToPrivateIdentity2(context);
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
