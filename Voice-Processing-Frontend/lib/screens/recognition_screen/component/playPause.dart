import 'package:flutter/material.dart';

import '../../../constants.dart';

class PlayPause extends StatelessWidget {
  const PlayPause({
    Key key, this.text,
  }) : super(key: key);
  final String text;

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

    return Text(text,
        style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold));
  }
}
