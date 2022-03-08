import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'onBoarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget screen = OnBoardingScreen();

  getScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isOnboearding = prefs.getBool('is_onboearding') ?? false;
    if (isOnboearding) {
      setState(() {
        screen = const HomeScreen();
      });
    } else {
      setState(() {
        screen = OnBoardingScreen();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => screen)));
    getScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 500,
          ),
        ),
      ),
    );
  }
}
