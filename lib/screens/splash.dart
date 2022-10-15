// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'onBoarding.dart';

class SplashScreen extends StatefulWidget {
  static double? startLatitude;
  static double? startLongitude;
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  final location = Location();
  
  getLocation() async {
    var _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();

      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    var currentLocation = await location.getLocation();
    setState(() {
      SplashScreen.startLatitude = currentLocation.latitude!;
      SplashScreen.startLongitude = currentLocation.longitude!;
      String userLocation = currentLocation.latitude!.toString() +
          ' ' +
          currentLocation.longitude!.toString();
      print(userLocation);
    });
  }

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => OnBoardingScreen())));
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: 500,
        ),
      ),
    );
  }
}
