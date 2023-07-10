import 'package:buddies_app/const.dart';
import 'package:buddies_app/features/pets/presentation/pets_page.dart';
import 'package:buddies_app/features/request/presentation/request_page.dart';
import 'package:buddies_app/features/users/presentation/account_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        bottomNavigationBar: CupertinoTabBar(
          border: Border.all(color: Colors.transparent),
          height: 60.0,
          currentIndex: _currentIndex,
          backgroundColor: white,
          activeColor: redColor,
          inactiveColor: primaryColor,
          iconSize: 35.0,
          items: [
            BottomNavigationBarItem(
              icon: BuddiesIcons.mascotasIcon(
                  sizeIcon: 35.0, color: primaryColor),
              activeIcon:
                  BuddiesIcons.mascotasIcon(sizeIcon: 35.0, color: redColor),
              label: 'Mascotas',
            ),
            BottomNavigationBarItem(
              icon: BuddiesIcons.serviciosIcon(
                  sizeIcon: 35.0, color: primaryColor),
              activeIcon:
                  BuddiesIcons.serviciosIcon(sizeIcon: 35.0, color: redColor),
              label: 'Servicios',
            ),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: primaryColor,
                ),
                activeIcon: Icon(Icons.account_circle_rounded, color: redColor),
                label: 'Cuenta'),
          ],
          onTap: navigationTapped,
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: const [PetsPage(), RequestPage(), AccountPage()],
        ));
  }
}
