import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/button_back_app_bar_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_text_form_field_labelled_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title: const ButtonBackAppBarWidget(title: "Edit Profil"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: white,
                  backgroundImage: const AssetImage("assets/jpeg/ikis.jpeg"),
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              CustomTextFormFieldLabelledWidget(
                label: "Nama Lengkap",
                controller: fullNameController,
              ),
              CustomTextFormFieldLabelledWidget(
                label: "Usia",
                controller: fullNameController,
              ),
              CustomTextFormFieldLabelledWidget(
                label: "Status",
                controller: fullNameController,
              ),
              CustomTextFormFieldLabelledWidget(
                label: "NIM",
                controller: fullNameController,
              ),
              CustomTextFormFieldLabelledWidget(
                label: "Fakultas/Jurusan",
                controller: fullNameController,
              ),
              CustomTextFormFieldLabelledWidget(
                label: "Instansi",
                controller: fullNameController,
              ),
              CustomTextFormFieldLabelledWidget(
                label: "Domisili",
                controller: fullNameController,
              ),
              CustomButtonWidget(
                text: "Simpan",
                isGradient: true,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
