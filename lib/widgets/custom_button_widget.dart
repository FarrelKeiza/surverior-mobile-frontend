import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.text,
    this.color = const Color(0xFF0F2A5D),
    required this.onPressed,
    this.isLoading = false,
    this.isEnable = true,
    this.isAutoSize = true,
    this.isBordered = false,
    this.isGradient = false,
    this.borderRadius = 10,
    this.height = 50,
    this.width = 80,
    this.fontSize = 14,
    this.fontColor = Colors.white,
    this.fontWeight = FontWeight.w400,
    this.suffixIcon,
  });

  final String text;
  final bool isLoading, isEnable, isAutoSize, isBordered, isGradient;
  final Function() onPressed;
  final Color color, fontColor;
  final double height, width, fontSize, borderRadius;
  final FontWeight fontWeight;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return isGradient
        ? Container(
            height: height,
            width: isAutoSize ? double.maxFinite : null,
            decoration: BoxDecoration(
              gradient: primaryGradient,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
              ),
              child: isLoading == true
                  ? CupertinoActivityIndicator(
                      color: white,
                    )
                  : Text(
                      text,
                      style: primaryTextStyle.copyWith(
                        fontWeight: fontWeight,
                        fontSize: fontSize,
                        color: fontColor,
                      ),
                    ),
            ),
          )
        : SizedBox(
            height: height,
            width: isAutoSize ? double.maxFinite : null,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(5),
                surfaceTintColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  side: isBordered ? BorderSide(color: white) : BorderSide.none,
                ),
                elevation: 0,
                backgroundColor:
                    isEnable == true ? color : color.withValues(alpha: 0.5),
              ),
              onPressed: isEnable == true ? onPressed : () {},
              child: isLoading == true
                  ? CupertinoActivityIndicator(
                      color: white,
                    )
                  : suffixIcon != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              text,
                              style: primaryTextStyle.copyWith(
                                fontWeight: fontWeight,
                                fontSize: fontSize,
                                color: fontColor,
                              ),
                            ),
                            const SizedBox(width: 8),
                            suffixIcon!,
                          ],
                        )
                      : Text(
                          text,
                          style: primaryTextStyle.copyWith(
                            fontWeight: fontWeight,
                            fontSize: fontSize,
                            color: fontColor,
                          ),
                        ),
            ),
          );
  }
}
