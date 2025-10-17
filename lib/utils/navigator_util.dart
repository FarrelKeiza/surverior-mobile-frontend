import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:surverior_frontend_mobile/pages/authentication/academic_identity_page.dart';
import 'package:surverior_frontend_mobile/pages/authentication/information_page.dart';
import 'package:surverior_frontend_mobile/pages/authentication/otp_validation_page.dart';
import 'package:surverior_frontend_mobile/pages/authentication/pin_page.dart';
import 'package:surverior_frontend_mobile/pages/authentication/private_identity2_page.dart';
import 'package:surverior_frontend_mobile/pages/authentication/private_identity_page.dart';
import 'package:surverior_frontend_mobile/pages/authentication/reason_page.dart';
import 'package:surverior_frontend_mobile/pages/authentication/reason_signing_up_page.dart';
import 'package:surverior_frontend_mobile/pages/authentication/select_authentication_page.dart';
import 'package:surverior_frontend_mobile/pages/authentication/sign_in_page.dart';
import 'package:surverior_frontend_mobile/pages/authentication/sign_up_page.dart';

class NavigatorUtil {
  // Route Names
  static const String selectAuthentication = '/select-authentication';
  static const String selectRoleSignUp = '/select-role-sign-up';
  static const String privateIdentity = '/private-identity';
  static const String privateIdentity2 = '/private-identity-2';
  static const String academicIdentity = '/academic-identity';
  static const String signUp = '/sign-up';
  static const String signIn = '/sign-in';
  static const String informationPage = '/information-page';
  static const String pinPage = '/pin-page';
  static const String otpValidation = '/otp-validation';
  static const String reasonSigningUp = '/reason-signing-up';
  static const String reasonPage = '/reason-page';

  // Navigation Methods with Page Transition
  static void pushToSelectAuthentication(BuildContext context) {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const SelectAuthenticationPage(),
      ),
    );
  }

  static void pushToInformationPage(
      BuildContext context, int informationNumber) {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: InformationPage(
          informationNumber: informationNumber,
        ),
      ),
    );
  }

  static void pushToPrivateIdentity(BuildContext context) {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const PrivateIdentityPage(),
      ),
    );
  }

  static void pushToPrivateIdentity2(BuildContext context) {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const PrivateIdentity2Page(),
      ),
    );
  }

  static void pushToAcademicIdentity(BuildContext context, int academicRole) {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: AcademicIdentityPage(academicRole: academicRole),
      ),
    );
  }

  static void pushToPinPage(BuildContext context) {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const PinPage(),
      ),
    );
  }

  static void pushToSignUp(BuildContext context) {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const SignUpPage(),
      ),
    );
  }

  static void pushToOtpValidation(BuildContext context) {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const OtpValidationPage(),
      ),
    );
  }

  static void pushToReasonSigningUp(BuildContext context) {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const ReasonSigningUpPage(),
      ),
    );
  }

  static void pushToReasonPage(BuildContext context) {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const ReasonPage(),
      ),
    );
  }

  static void pushToSignIn(BuildContext context) {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const SignInPage(),
      ),
    );
  }

  static void pushToDynamicPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: page,
      ),
    );
  }

  // Push and Replace Methods
  static void pushReplacementToDynamicPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: page,
      ),
    );
  }

  static void pushReplacementToSelectAuthentication(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const SelectAuthenticationPage(),
      ),
    );
  }

  static void pushReplacementToPrivateIdentity(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const PrivateIdentityPage(),
      ),
    );
  }

  static void pushReplacementToAcademicIdentity(
      BuildContext context, int academicRole) {
    Navigator.of(context).pushReplacement(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: AcademicIdentityPage(academicRole: academicRole),
      ),
    );
  }

  static void pushReplacementToSignUp(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: const SignUpPage(),
      ),
    );
  }

  // Pop Methods
  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void popUntil(BuildContext context, String routeName) {
    Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }

  static void popAndPushTo(BuildContext context, Widget page) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: page,
      ),
    );
  }

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case selectAuthentication:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SelectAuthenticationPage(),
          settings: settings,
        );
      case privateIdentity:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const PrivateIdentityPage(),
          settings: settings,
        );
      case privateIdentity2:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const PrivateIdentity2Page(),
          settings: settings,
        );
      case academicIdentity:
        final args = settings.arguments as Map<String, dynamic>?;
        final academicRole = args?['academicRole'] as int? ?? 0;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: AcademicIdentityPage(academicRole: academicRole),
          settings: settings,
        );
      case signUp:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SignUpPage(),
          settings: settings,
        );
      case signIn:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SignInPage(),
          settings: settings,
        );
      case informationPage:
        final args = settings.arguments as Map<String, dynamic>?;
        final informationNumber = args?['informationNumber'] as int? ?? 0;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: InformationPage(informationNumber: informationNumber),
          settings: settings,
        );
      case pinPage:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const PinPage(),
          settings: settings,
        );
      case otpValidation:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const OtpValidationPage(),
          settings: settings,
        );
      case reasonSigningUp:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const ReasonSigningUpPage(),
          settings: settings,
        );
      default:
        return null;
    }
  }

  // Named Route Navigation Methods
  static void pushNamed(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  static void pushReplacementNamed(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  static void pushNamedAndRemoveUntil(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  // Convenience methods for named routes with parameters
  static void pushNamedToInformationPage(
      BuildContext context, int informationNumber) {
    Navigator.of(context).pushNamed(
      informationPage,
      arguments: {'informationNumber': informationNumber},
    );
  }

  static void pushNamedToAcademicIdentity(
      BuildContext context, int academicRole) {
    Navigator.of(context).pushNamed(
      academicIdentity,
      arguments: {'academicRole': academicRole},
    );
  }

  static void pushReplacementNamedToAcademicIdentity(
      BuildContext context, int academicRole) {
    Navigator.of(context).pushReplacementNamed(
      academicIdentity,
      arguments: {'academicRole': academicRole},
    );
  }

  static void pushAndRemoveUntil(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: page,
        type: PageTransitionType.rightToLeft,
      ),
      (Route<dynamic> route) => false,
    );
  }
}
