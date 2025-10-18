import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/pages/questionnaire/builder/create_metadata_questionnaire_page.dart';
import 'package:surverior_frontend_mobile/providers/navigation_bar_provider.dart';
import 'package:surverior_frontend_mobile/providers/authentication_provider.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

// class NavigationBarWidget extends StatelessWidget {
class NavigationBarWidget extends HookWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Provider.of<AuthenticationProvider>(context, listen: false)
          .loadAuthData();
      return null;
    }, []);

    return Scaffold(
      body: Consumer2<NavigationBarProvider, AuthenticationProvider>(
        builder: (context, navigationBarProvider, authProvider, child) {
          final isAcademic = authProvider.isAcademic;

          return Stack(
            children: [
              navigationBarProvider.body() ?? const SizedBox.shrink(),
              Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Align(
                  alignment: const Alignment(0.0, 1.0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: primaryGradient,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: white,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 50),
                              blurRadius: 20,
                              spreadRadius: 2,
                              color: secondaryColor.withValues(alpha: 0.5),
                            ),
                            BoxShadow(
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                              spreadRadius: 1,
                              color: secondaryColor.withValues(alpha: 0.2),
                            ),
                            BoxShadow(
                              offset: const Offset(0, 2),
                              blurRadius: 15,
                              spreadRadius: -2,
                              color: secondaryColor.withValues(alpha: 0.1),
                            ),
                            BoxShadow(
                              offset: const Offset(50, 30),
                              blurRadius: 20,
                              spreadRadius: -2,
                              color: secondaryColor.withValues(alpha: 0.3),
                            ),
                            BoxShadow(
                              offset: const Offset(-50, 30),
                              blurRadius: 20,
                              spreadRadius: -2,
                              color: secondaryColor.withValues(alpha: 0.3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BottomNavigationBar(
                            type: BottomNavigationBarType.fixed,
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            showSelectedLabels: false,
                            showUnselectedLabels: false,
                            unselectedItemColor: white,
                            currentIndex: navigationBarProvider.currentIndex,
                            onTap: (value) {
                              navigationBarProvider.setCurrentIndex(value);
                            },
                            items: [
                              BottomNavigationBarItem(
                                icon: navigationBarProvider.currentIndex == 0
                                    ? Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: gradientWidgetColorMask(
                                          const Icon(Icons.home_filled),
                                        ))
                                    : const Icon(Icons.home_filled),
                                label: 'Beranda',
                              ),
                              BottomNavigationBarItem(
                                icon: navigationBarProvider.currentIndex == 1
                                    ? Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: gradientWidgetColorMask(
                                          const Icon(Icons.mail),
                                        ))
                                    : const Icon(Icons.mail),
                                label: 'Notifikasi',
                              ),
                              // Only show "Tambah" (Add) item for academic users
                              if (isAcademic)
                                BottomNavigationBarItem(
                                  icon: navigationBarProvider.currentIndex == 2
                                      ? Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color: white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: gradientWidgetColorMask(
                                            const Icon(Icons.add),
                                          ))
                                      : const Icon(Icons.add),
                                  label: 'Tambah',
                                ),
                              BottomNavigationBarItem(
                                icon: navigationBarProvider.currentIndex ==
                                        (isAcademic ? 3 : 2)
                                    ? Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: gradientWidgetColorMask(
                                          const Icon(CupertinoIcons.gift_fill),
                                        ))
                                    : const Icon(CupertinoIcons.gift_fill),
                                label: 'Reward',
                              ),
                              BottomNavigationBarItem(
                                icon: navigationBarProvider.currentIndex ==
                                        (isAcademic ? 4 : 3)
                                    ? Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: gradientWidgetColorMask(
                                          const Icon(CupertinoIcons.ellipsis),
                                        ))
                                    : const Icon(CupertinoIcons.ellipsis),
                                label: 'Profil',
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Conditionally show the floating action button only for academic users
                      if (isAcademic)
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child:
                                      const CreateMetadataQuestionnairePage(),
                                  type: PageTransitionType.scale,
                                  alignment: const Alignment(0.0, 1.0),
                                  duration: const Duration(milliseconds: 300),
                                ),
                              );
                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                gradient: primaryGradient,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: white,
                                  width: 3,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
