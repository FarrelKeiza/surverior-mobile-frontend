import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/models/department.dart';
import 'package:surverior_frontend_mobile/pages/authentication/sign_in_page.dart';
import 'package:surverior_frontend_mobile/providers/department_provider.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/background_gradient_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_question_auth_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_text_form_field_widget.dart';
import 'package:surverior_frontend_mobile/providers/authentication_provider.dart';
import 'package:surverior_frontend_mobile/widgets/custom_dropdown_button_labelled_widget.dart';
import 'package:surverior_frontend_mobile/providers/college_provider.dart';
import 'package:surverior_frontend_mobile/models/college.dart';

// class AcademicIdentityPage extends StatefulWidget {
//   const AcademicIdentityPage({
//     super.key,
//     required this.academicRole,
//   });
//
//   final int academicRole;
//
//   @override
//   State<AcademicIdentityPage> createState() => _AcademicIdentityPageState();
// }
//
// class _AcademicIdentityPageState extends State<AcademicIdentityPage> {
//   TextEditingController academicIdentityController = TextEditingController();
//   TextEditingController dateInController = TextEditingController();
//   TextEditingController collegeController = TextEditingController();
//   TextEditingController departmentController = TextEditingController();
//
//   void datePicker() async {
//     var pickedDate = await showDatePicker(
//       context: context,
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//
//     if (pickedDate != null) {
//       setState(() {
//         dateInController.text =
//             "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
//       });
//     }
//   }
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
//               Align(
//                 alignment: Alignment.center,
//                 child: Image.asset(
//                   "assets/png/logo-white.png",
//                   height: MediaQuery.of(context).size.height * 0.1,
//                 ),
//               ),
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
//                         widget.academicRole == 1
//                             ? "Identitas Mahasiswa"
//                             : "Identitas Dosen",
//                         style: primaryTextStyle,
//                       ),
//                     ),
//                     const Divider(),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     CustomTextFormFieldWidget(
//                       hintText: widget.academicRole == 1 ? "NIM" : "NIDN",
//                       controller: academicIdentityController,
//                       isFilled: true,
//                       prefixIcon: Icon(
//                         Icons.person_outlined,
//                         color: black1,
//                       ),
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         datePicker();
//                       },
//                       child: CustomTextFormFieldWidget(
//                         hintText: widget.academicRole == 1
//                             ? "Tanggal Masuk"
//                             : "Tanggal Mulai Mengampu",
//                         controller: dateInController,
//                         isFilled: true,
//                         isEnabled: false,
//                         prefixIcon: Icon(
//                           Icons.calendar_month_outlined,
//                           color: black1,
//                         ),
//                         suffixIcon: Icon(
//                           Icons.keyboard_arrow_down_outlined,
//                           color: black1,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     CustomTextFormFieldWidget(
//                       hintText: "Asal Kampus",
//                       controller: collegeController,
//                       isFilled: true,
//                       isEnabled: false,
//                       prefixIcon: Icon(
//                         Icons.domain_outlined,
//                         color: black1,
//                       ),
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
//                     ),
//                     CustomTextFormFieldWidget(
//                       hintText: "Fakultas/Jurusan",
//                       controller: departmentController,
//                       isFilled: true,
//                       prefixIcon: Icon(
//                         Icons.school_outlined,
//                         color: black1,
//                       ),
//                     ),
//                     SizedBox(
//                       height: defaultPadding,
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

class AcademicIdentityPage extends HookWidget {
  const AcademicIdentityPage({
    super.key,
    required this.academicRole,
  });

  final int academicRole;

  @override
  Widget build(BuildContext context) {
    final collegeProvider =
        useMemoized(() => Provider.of<CollegeProvider>(context, listen: false));
    final selectedProfileCollege = useState<College?>(null);

    final departmentProvider = useMemoized(
        () => Provider.of<DepartmentProvider>(context, listen: false));
    final selectedProfileDepartment = useState<Department?>(null);

    useEffect(() {
      collegeProvider.fetchColleges();
      departmentProvider.fetchDepartments();
      return null;
    }, []);

    final colleges = context.watch<CollegeProvider>().colleges;
    final collegeLoading = context.watch<CollegeProvider>().isLoading;
    final collegeError = context.watch<CollegeProvider>().error;

    final departments = context.watch<DepartmentProvider>().departments;
    final departmentLoading = context.watch<DepartmentProvider>().isLoading;
    final departmentError = context.watch<DepartmentProvider>().error;

    final TextEditingController academicIdentityController =
        useTextEditingController();
    final TextEditingController dateInController = useTextEditingController();
    final TextEditingController collegeController = useTextEditingController();
    final TextEditingController departmentController =
        useTextEditingController();

    void datePicker() async {
      var pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );

      if (pickedDate != null) {
        dateInController.text =
            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      }
    }

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
                        academicRole == 1
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
                      hintText: academicRole == 1 ? "NIM" : "NIDN",
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
                        hintText: academicRole == 1
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
                    // CustomTextFormFieldWidget(
                    //   hintText: "Asal Kampus",
                    //   controller: collegeController,
                    //   isFilled: true,
                    //   prefixIcon: Icon(
                    //     Icons.domain_outlined,
                    //     color: black1,
                    //   ),
                    // ),
                    CustomDropdownButtonLabelledWidget(
                      paddingBottom: 0,
                      label: "Asal Kampus",
                      showLabel: false,
                      prefixIcon: Icon(
                        Icons.domain_outlined,
                        color: black1,
                      ),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: black,
                      ),
                      value: selectedProfileCollege.value,
                      items: colleges
                              ?.map((col) => DropdownMenuItem<College>(
                                    value: col,
                                    child: Text(col.name ?? "Unknown"),
                                  ))
                              .toList() ??
                          [],
                      onChanged: (value) {
                        collegeController.text = (value as College).name!;
                        selectedProfileCollege.value = value as College?;
                      },
                    ),
                    if (collegeLoading) const SizedBox(height: 8),
                    if (collegeLoading) const LinearProgressIndicator(),
                    if (collegeError.isNotEmpty)
                      Text(collegeError,
                          style: const TextStyle(color: Colors.red)),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    // CustomTextFormFieldWidget(
                    //   hintText: "Fakultas/Jurusan",
                    //   controller: departmentController,
                    //   isFilled: true,
                    //   prefixIcon: Icon(
                    //     Icons.school_outlined,
                    //     color: black1,
                    //   ),
                    // ),
                    CustomDropdownButtonLabelledWidget(
                      paddingBottom: 0,
                      label: "Fakultas/Jurusan",
                      showLabel: false,
                      prefixIcon: Icon(
                        Icons.school_outlined,
                        color: black1,
                      ),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: black,
                      ),
                      value: selectedProfileDepartment.value,
                      items: departments
                              ?.map((dep) => DropdownMenuItem<Department>(
                                    value: dep,
                                    child: Text(dep.name ?? "Unknown"),
                                  ))
                              .toList() ??
                          [],
                      onChanged: (value) {
                        departmentController.text = (value as Department).name!;
                        selectedProfileDepartment.value = value as Department?;
                      },
                    ),
                    if (departmentLoading) const SizedBox(height: 8),
                    if (departmentLoading) const LinearProgressIndicator(),
                    if (departmentError.isNotEmpty)
                      Text(departmentError,
                          style: const TextStyle(color: Colors.red)),
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
                        final id = academicIdentityController.text.trim();
                        final dateIn = dateInController.text.trim();
                        final college = collegeController.text.trim();
                        final department = departmentController.text.trim();
                        final type = academicRole == 1 ? 'student' : 'lecturer';

                        if (id.isEmpty ||
                            dateIn.isEmpty ||
                            college.isEmpty ||
                            department.isEmpty ||
                            selectedProfileDepartment.value == null ||
                            selectedProfileCollege.value == null) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill all academic fields'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        context.read<AuthenticationProvider>().setAcademicInfo(
                              academicId: id,
                              academicType: type,
                              dateIn: dateIn,
                              college: college,
                              department: department,
                              collegeId: selectedProfileCollege.value!.id!,
                              departmentId:
                                  selectedProfileDepartment.value!.id!,
                            );

                        if (!context.mounted) return;
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
