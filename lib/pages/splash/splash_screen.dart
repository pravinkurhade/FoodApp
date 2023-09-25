import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/pages/home/home.dart';

import '../../utlis/common/navigation.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = 'splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer.run(() async {
        Navigation.intentWithClearAllRoutes(context, HomeScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            height: 100,
            alignment: Alignment.center, // This is needed
            child: Image.asset(
              'images/plateron.png',
              fit: BoxFit.contain,
              width: 300,
            ),
          ),
        ),
      ),
    );
  }
}
