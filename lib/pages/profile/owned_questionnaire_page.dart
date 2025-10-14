import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/button_back_app_bar_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';
import 'package:surverior_frontend_mobile/widgets/questionnaire_card_widget.dart';

class OwnedQuestionnairePage extends StatelessWidget {
  const OwnedQuestionnairePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title: const ButtonBackAppBarWidget(title: "Kuesioner Saya"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return const QuestionnaireCardWidget(
                isOwned: true,
              );
            },
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(defaultPadding),
        color: white,
        child: CustomButtonWidget(
          text: "Buat Kuesioner Baru",
          isGradient: true,
          isLoading: false,
          onPressed: () {},
        ),
      ),
    );
  }
}
