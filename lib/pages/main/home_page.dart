import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/filter_dropdown_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/home_status_card_widget.dart';
import 'package:surverior_frontend_mobile/widgets/questionnaire_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const HomeStatusCardWidget(),
              SizedBox(
                height: defaultPadding,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FilterDropdownButtonWidget(
                      hintText: "Proges",
                      items: const [],
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(width: 10),
                    FilterDropdownButtonWidget(
                      hintText: "Kategori",
                      items: const [],
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const QuestionnaireCardWidget(
                    isProgress: true,
                  );
                },
              ),
              const SizedBox(
                height: 65,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
