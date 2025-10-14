import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/pages/authentication/select_authentication_page.dart';
import 'package:surverior_frontend_mobile/providers/authentication_provider.dart';
import 'package:surverior_frontend_mobile/providers/navigation_bar_provider.dart';
import 'package:surverior_frontend_mobile/providers/questionnaire_provider.dart';
import 'package:surverior_frontend_mobile/utils/navigator_util.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(const Surverior());
}

class Surverior extends StatelessWidget {
  const Surverior({super.key});

  @override
  Widget build(BuildContext context) {
    setStatusBarColorBasedOnTheme(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NavigationBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => QuestionnaireProvider(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: white),
              useMaterial3: true,
            ),
            initialRoute: NavigatorUtil.selectAuthentication,
            onGenerateRoute: NavigatorUtil.generateRoute,
            home: const SelectAuthenticationPage(),
          );
        },
      ),
    );
  }
}
