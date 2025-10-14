import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/background_gradient_widget.dart';
import 'package:surverior_frontend_mobile/widgets/decorative_bubble_widget.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({
    super.key,
    required this.informationNumber,
  });

  final int informationNumber;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        informationNumber == 1
            ? NavigatorUtil.pushToPrivateIdentity(context)
            : NavigatorUtil.pushToPinPage(context);
      },
      child: BackgroundGradientWidget(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
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
              ...informationNumber == 1
                  ? information1(context)
                  : information2(context),
              Text(
                "Tekan di mana untuk lanjut",
                style: primaryTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> information1(BuildContext context) {
    return [
      DecorativeBubbleWidget(
        direction: BubbleDirection.right,
        backgroundColor: Colors.white,
        child: Text(
          "Selanjutnya, kami akan melakukan profiling agar kami dapat menampilkan kuesioner yang relevan bagi Anda. Untuk itu, silakan isi data berikut dengan valid.",
          style: primaryTextStyle.copyWith(color: primaryColor),
        ),
      ),
      SizedBox(
        height: defaultPadding,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: DecorativeBubbleWidget(
              direction: BubbleDirection.left,
              backgroundColor: tertiaryColor,
              child: Text(
                "Apakah data saya akan aman?",
                style: primaryTextStyle,
              ),
            ),
          ),
          const Spacer(),
          Flexible(
            flex: 6,
            child: Image.asset(
              "assets/png/mr-cat.png",
              height: height(context) * 0.2,
            ),
          ),
        ],
      ),
      SizedBox(
        height: defaultPadding,
      ),
      DecorativeBubbleWidget(
        direction: BubbleDirection.right,
        trianglePosition: TrianglePosition.top,
        backgroundColor: Colors.white,
        child: RichText(
          text: TextSpan(
            text: "Tentu, silakan pahami ",
            style: primaryTextStyle.copyWith(color: primaryColor),
            children: [
              WidgetSpan(
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "Syarat dan Ketentuan",
                    style: primaryTextStyle.copyWith(
                        color: tertiaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: tertiaryColor),
                  ),
                ),
              ),
              TextSpan(
                text: " kami.",
                style: primaryTextStyle.copyWith(color: primaryColor),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: defaultPadding,
      )
    ];
  }

  List<Widget> information2(BuildContext context) {
    return [
      DecorativeBubbleWidget(
        direction: BubbleDirection.right,
        backgroundColor: Colors.white,
        child: Text(
          "Untuk menjaga keamanan transaksi Anda, silakan buat PIN transaksi Anda.",
          style: primaryTextStyle.copyWith(color: primaryColor),
        ),
      ),
      SizedBox(
        height: defaultPadding,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Image.asset(
          "assets/png/mr-cat.png",
          height: height(context) * 0.2,
        ),
      ),
      SizedBox(
        height: defaultPadding,
      )
    ];
  }
}
