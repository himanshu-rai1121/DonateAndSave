import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:donate_platelets/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:donate_platelets/screens/history.dart';
import 'package:donate_platelets/screens/requests.dart';
import 'package:donate_platelets/screens/signUp.dart';

import '../constants/color_constants.dart';
import '../screens/findDonor.dart';
import '../screens/profilePage.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 2;
  List<Widget> _screens = [
    Requests(),
    FindDonor(),
    NewHomePage(),
    History(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        color: kPrimaryColor,
        buttonBackgroundColor: kPrimaryColor,
        backgroundColor: Color.fromARGB(255, 252, 252, 252),
        animationDuration: Duration(milliseconds: 400),
        height: 60,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          Icon(
            Icons.person_add_alt_1,
            color: Color.fromRGBO(5, 98, 77, 1),
          ),
          Icon(
            Icons.search,
            color: Color.fromRGBO(5, 98, 77, 1),
          ),
          Icon(
            Icons.home,
            color: Color.fromRGBO(5, 98, 77, 1),
          ),
          Icon(
            Icons.history,
            color: Color.fromRGBO(5, 98, 77, 1),
          ),
          Icon(
            Icons.person,
            color: Color.fromRGBO(5, 98, 77, 1),
          ),
        ],
      ),
      body: _screens[_currentIndex],
    );
  }
}
