import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/providers/questionnaire_provider.dart';
import 'package:surverior_frontend_mobile/providers/user_provider.dart';
import 'package:surverior_frontend_mobile/providers/wallet_provider.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      Provider.of<UserProvider>(context, listen: false).fetchUserProfile();
      Provider.of<WalletProvider>(context, listen: false).fetchWallet();
      Provider.of<QuestionnaireProvider>(context, listen: false)
          .fetchQuestionnaires();
    });

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.wait([
              Provider.of<UserProvider>(context, listen: false)
                  .refreshUserProfile(),
              Provider.of<WalletProvider>(context, listen: false)
                  .refreshWallet(),
              Provider.of<QuestionnaireProvider>(context, listen: false)
                  .refreshQuestionnaires(),
            ]);
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.all(defaultPadding),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const HomeStatusCardWidget(),
                SizedBox(
                  height: defaultPadding,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Flexible(
                        child: FilterDropdownButtonWidget(
                          hintText: "Progress",
                          items: const [],
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: FilterDropdownButtonWidget(
                          hintText: "Kategori",
                          items: const [],
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Consumer<QuestionnaireProvider>(
                  builder: (context, questionnaireProvider, child) {
                    if (questionnaireProvider.isLoadingQuestionnaires) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (questionnaireProvider.questionnaireError.isNotEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Gagal memuat questionnaire',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              questionnaireProvider.questionnaireError,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                questionnaireProvider.refreshQuestionnaires();
                              },
                              child: const Text('Coba Lagi'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (questionnaireProvider.questionnaires.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.quiz_outlined,
                              size: 48,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Belum ada questionnaire',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Questionnaire akan muncul di sini',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: questionnaireProvider.questionnaires.length,
                      itemBuilder: (context, index) {
                        final questionnaire =
                            questionnaireProvider.questionnaires[index];
                        return QuestionnaireCardWidget(
                          questionnaire: questionnaire,
                          isProgress: false,
                        );
                      },
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
      ),
    );
  }
}
