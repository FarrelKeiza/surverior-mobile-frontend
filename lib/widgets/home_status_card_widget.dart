import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/providers/user_provider.dart';
import 'package:surverior_frontend_mobile/providers/wallet_provider.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class HomeStatusCardWidget extends StatelessWidget {
  const HomeStatusCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, WalletProvider>(
      builder: (context, userProvider, walletProvider, child) {
        return Container(
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            gradient: primaryGradient,
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: white,
                    // backgroundImage: const AssetImage("assets/jpeg/ikis.jpeg"),
                    child: Icon(
                      Icons.person,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Hai,\n",
                      style: primaryTextStyle,
                      children: [
                        TextSpan(
                          text: userProvider.userName,
                          style: primaryTextStyle.copyWith(
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/png/coins-1.png"),
                          Text(
                            walletProvider.balances?.toInt().toString() ?? "0",
                            style: primaryTextStyle,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Top Up",
                              style: primaryTextStyle.copyWith(
                                color: primaryColor,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: primaryGradient,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add,
                                color: white,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // SizedBox(
              //   height: defaultPadding,
              // ),
              // Text(
              //   "Progres minggu ini",
              //   style: primaryTextStyle,
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     Container(
              //       padding: const EdgeInsets.all(5),
              //       decoration: BoxDecoration(
              //         color: white,
              //         borderRadius: BorderRadius.circular(defaultBorderRadius),
              //       ),
              //       child: IntrinsicWidth(
              //         child: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             Image.asset("assets/png/poins.png"),
              //             Flexible(
              //               child: Text(
              //                 "4560",
              //                 style: primaryTextStyle.copyWith(
              //                   color: primaryColor,
              //                 ),
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     Container(
              //       padding: const EdgeInsets.all(5),
              //       decoration: BoxDecoration(
              //         color: white,
              //         borderRadius: BorderRadius.circular(defaultBorderRadius),
              //       ),
              //       child: IntrinsicWidth(
              //         child: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             gradientWidgetColorMask(
              //               const Icon(Icons.list_alt_rounded),
              //             ),
              //             Flexible(
              //               child: Text(
              //                 "3",
              //                 style: primaryTextStyle.copyWith(
              //                   color: primaryColor,
              //                 ),
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     Container(
              //       padding: const EdgeInsets.all(5),
              //       decoration: BoxDecoration(
              //         color: white,
              //         borderRadius: BorderRadius.circular(defaultBorderRadius),
              //       ),
              //       child: IntrinsicWidth(
              //         child: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             gradientWidgetColorMask(
              //               const Icon(Icons.question_mark_rounded),
              //             ),
              //             Flexible(
              //               child: Text(
              //                 "43",
              //                 style: primaryTextStyle.copyWith(
              //                   color: primaryColor,
              //                 ),
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        );
      },
    );
  }
}
