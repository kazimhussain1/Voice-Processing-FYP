import 'dart:async';

import 'package:flutter/material.dart';
import './components/body.dart';
import 'package:fyp/screens/mainScreen/mainScreen.dart';

class SplashScreen extends StatefulWidget {
  static final routeName = "/splashScreen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body());
  }
}
