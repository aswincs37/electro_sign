import 'package:electrosign/screens/home_screen.dart';
import 'package:electrosign/screens/mobile/mobile_home_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 1000) {
      return HomeScreen();
    } else {
      return MobileHomeScreen();
    }
  }
}
