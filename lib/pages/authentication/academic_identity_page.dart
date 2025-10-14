import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/pages/authentication/sign_in_page.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/background_gradient_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_question_auth_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_text_form_field_widget.dart';

class AcademicIdentityPage extends StatefulWidget {
  const AcademicIdentityPage({
    super.key,
    required this.academicRole,
  });

  final int academicRole;

  @override
  State<AcademicIdentityPage> createState() => _AcademicIdentityPageState();
}

class _AcademicIdentityPageState extends State<AcademicIdentityPage> {
  TextEditingController academicIdentityController = TextEditingController();
  TextEditingController dateInController = TextEditingController();
  TextEditingController collegeController = TextEditingController();
  TextEditingController departmentController = TextEditingController();

  void datePicker() async {
    var pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        dateInController.text =
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
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/png/logo-white.png",
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ),
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
                        widget.academicRole == 1
                            ? "Identitas Mahasiswa"
                            : "Identitas Dosen",
                        style: primaryTextStyle,
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomTextFormFieldWidget(
                      hintText: widget.academicRole == 1 ? "NIM" : "NIDN",
                      controller: academicIdentityController,
                      isFilled: true,
                      prefixIcon: Icon(
                        Icons.person_outlined,
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
                        hintText: widget.academicRole == 1
                            ? "Tanggal Masuk"
                            : "Tanggal Mulai Mengampu",
                        controller: dateInController,
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
                    CustomTextFormFieldWidget(
                      hintText: "Asal Kampus",
                      controller: collegeController,
                      isFilled: true,
                      isEnabled: false,
                      prefixIcon: Icon(
                        Icons.domain_outlined,
                        color: black1,
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomTextFormFieldWidget(
                      hintText: "Fakultas/Jurusan",
                      controller: departmentController,
                      isFilled: true,
                      prefixIcon: Icon(
                        Icons.school_outlined,
                        color: black1,
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomButtonWidget(
                      text: "Lanjut",
                      color: secondaryColor,
                      onPressed: () {
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
