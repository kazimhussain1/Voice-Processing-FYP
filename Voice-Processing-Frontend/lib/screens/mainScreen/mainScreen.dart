import 'package:flutter/material.dart';
import 'package:fyp/screens/recognition_screen/recognitionScreen.dart';
import 'package:fyp/screens/recording_screen/recordingScreen.dart';
import './components/Button.dart';
import './components/upperHeadingPicture.dart';
import './components/Seaprator.dart';

class MainScreen extends StatelessWidget {
  static final routeName = "/mainScreen";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
//    double height = MediaQuery.of(context).size.height;

// Get the proportionate height as per screen size
    double getProportionateScreenWidth(double inputWidth) {
      double screenWidth = width;
      // 375 is the layout width that designer use
      return (inputWidth / 375.0) * screenWidth;
    }

    return Scaffold(
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
          UpperPictureHeading(),
          Container(
              width: double.infinity,
              child: Column(
                children: [
                  Button(
                      text: "Speaker Diarization",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecordingScreen(title: "Speaker Diarization"),
                          ),
                        );
                      }),
                  SizedBox(height: getProportionateScreenWidth(10)),
                  Seperator(),
                  SizedBox(height: getProportionateScreenWidth(10)),
                  Button(
                      text: "Voice Recognition",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecognitionScreen(title: "Voice Recognition"),
                          ),
                        );
                      })
                ],
              ))
        ])));
  }
}
