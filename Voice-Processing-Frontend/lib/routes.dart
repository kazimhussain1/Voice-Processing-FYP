import 'package:flutter/material.dart';
import 'package:fyp/screens/recognition_screen/recognitionScreen.dart';
import 'package:fyp/screens/recording_screen/recordingScreen.dart';
import './screens/mainScreen/mainScreen.dart';
import './screens/SplashScreen/splashScreen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  MainScreen.routeName: (context) => MainScreen(),
  RecordingScreen.routeName: (context) => RecordingScreen(),
  RecognitionScreen.routeName: (context) => RecognitionScreen()
};
