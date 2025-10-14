import 'package:flutter/widgets.dart';
import 'package:surverior_frontend_mobile/pages/main/home_page.dart';
import 'package:surverior_frontend_mobile/pages/main/notification_page.dart';
import 'package:surverior_frontend_mobile/pages/main/profile_page.dart';
import 'package:surverior_frontend_mobile/pages/main/withdrawal_page.dart';

class NavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  List<Widget?> pages = [
    const HomePage(),
    const NotificationPage(),
    null,
    const WithdrawalPage(),
    const ProfilePage(),
  ];

  Widget? body() {
    return pages.elementAt(_currentIndex);
  }

  setCurrentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
