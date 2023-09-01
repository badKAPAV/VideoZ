import 'package:flutter/material.dart';
import 'package:video_uploader/constants.dart';

import '../widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            showSelectedLabels: true,
            showUnselectedLabels: false,
            backgroundColor: backgroundColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.white,
            currentIndex: pageIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 30,
                  ),
                  activeIcon: Icon(Icons.home, size: 30),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search_rounded,
                    size: 30,
                  ),
                  label: 'Search'),
              BottomNavigationBarItem(icon: CustomIcon(), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.messenger_outline_rounded,
                    size: 30,
                  ),
                  activeIcon: Icon(
                    Icons.messenger_rounded,
                    size: 30,
                  ),
                  label: 'Messages'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_outline_rounded,
                    size: 30,
                  ),
                  activeIcon: Icon(
                    Icons.person_rounded,
                    size: 30,
                  ),
                  label: 'Profile'),
            ]),
        body: pages[pageIndex],
      ),
    );
  }
}
