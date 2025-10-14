import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/background_gradient_widget.dart';
import 'package:surverior_frontend_mobile/widgets/custom_button_widget.dart';

class SelectAuthenticationPage extends StatelessWidget {
  const SelectAuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundGradientWidget(
      child: Column(
        children: [
          const Expanded(
            flex: 2,
            child: SizedBox.shrink(),
          ),
          Expanded(
            flex: 4,
            child: Image.asset("assets/png/logo-white.png"),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: [
                  CustomButtonWidget(
                    text: "DAFTAR",
                    color: white,
                    borderRadius: 5,
                    height: 60,
                    fontSize: 20,
                    fontColor: Colors.blue,
                    fontWeight: regular,
                    onPressed: () {
                      NavigatorUtil.pushToSignUp(context);
                    },
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  CustomButtonWidget(
                    text: "MASUK",
                    color: Colors.transparent,
                    isBordered: true,
                    borderRadius: 5,
                    height: 60,
                    fontSize: 20,
                    fontColor: white,
                    fontWeight: regular,
                    onPressed: () {
                      NavigatorUtil.pushToSignIn(context);
                    },
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    "©2025 Surverior",
                    style: primaryTextStyle,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
