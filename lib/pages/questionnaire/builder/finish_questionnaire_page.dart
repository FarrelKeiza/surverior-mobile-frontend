import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';

class FinishQuestionnairePage extends StatelessWidget {
  const FinishQuestionnairePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: SizedBox.expand(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/png/checkmark.png',
                            width: 150, height: 150),
                        const SizedBox(height: 15),
                        Text(
                          'Selamat!',
                          style: GoogleFonts.onest(
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Kuesioner Anda telah dipublikasikan!',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('surveyor.id/survey/12421', style: GoogleFonts.onest(
                                  fontSize: 16,
                                  color: black1,
                                ),),
                                IconButton(
                                  onPressed: () {},
                                  icon: Transform.rotate(
                                    angle: math.pi / -4,
                                    child: const Icon(
                                      Icons.link,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Bagikan untuk menjangkau lebih banyak responden!',
                          style: GoogleFonts.onest(
                              fontSize: 10, color: primaryColor),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      NavigatorUtil.pushToDynamicPage(
                        context,
                        const FinishQuestionnairePage(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Tutup',
                      style: GoogleFonts.onest(fontSize: 16, color: white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
