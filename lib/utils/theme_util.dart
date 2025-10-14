import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

double defaultPadding = 20;
double defaultBorderRadius = 15;

String formatTime(bool isDate, {DateTime? date}) {
  final DateFormat formatterDate = DateFormat('dd MMM yyyy', 'id');
  final DateFormat formatterJam = DateFormat('HH.mm');
  String formattedDate = "";

  if (isDate) {
    formattedDate = formatterDate.format(date!.add(const Duration(hours: 7)));

    return formattedDate;
  } else {
    formattedDate = formatterJam.format(date!.add(const Duration(hours: 7)));

    return formattedDate;
  }
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

bool isPotrait(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.portrait;
}

bool keyboardIsOpen(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom != 0;
}

Color primaryColor = const Color(0xff4567BF);
Color secondaryColor = const Color(0xFF0F2A5D);
Color tertiaryColor = const Color(0xFF6accda);
Color accentColor = const Color(0xff5b9ba3);
Color gradientColorPrimary = const Color(0xFF5B9BA3);
Color gradientColorSecondary = const Color(0xFF4567BF);
Color fieldColor = const Color(0xFFacbfe2);
Color black = const Color(0xFF000000);
Color black1 = const Color(0xFF18181b);
Color black2 = const Color(0xFF09090b);
Color white = const Color(0xFFFFFFFF);
Color white2 = const Color(0xFFF3F3F7);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;

LinearGradient primaryGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    gradientColorPrimary,
    gradientColorSecondary,
  ],
);

ShaderMask gradientWidgetColorMask(Widget child) {
  return ShaderMask(
    shaderCallback: (bounds) {
      return primaryGradient.createShader(
        Rect.fromLTWH(
          0,
          0,
          bounds.width,
          bounds.height,
        ),
      );
    },
    blendMode: BlendMode.srcIn,
    child: child,
  );
}

TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: white,
  fontWeight: regular,
);

TextStyle secondaryTextStyle = GoogleFonts.poppins(
  color: black1,
  fontWeight: regular,
);

TextStyle eduPelitaTextStyle = GoogleFonts.comfortaa(
  color: black1,
  fontWeight: regular,
);

void setStatusBarColorBasedOnTheme(BuildContext context) {
  final theme = Theme.of(context);
  final backgroundColor = white;
  final brightness = theme.brightness;

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: backgroundColor,
      statusBarIconBrightness:
          brightness == Brightness.light ? Brightness.dark : Brightness.light,
      statusBarBrightness: brightness,
    ),
  );
}
