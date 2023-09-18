import 'package:flutter/material.dart';

import '../../../constants.dart';


class Body extends StatelessWidget {
  const Body({
    Key key,
  
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

// Get the proportionate height as per screen size
    double getProportionateScreenHeight(double inputHeight) {
      double screenHeight = height;
      // 812 is the layout height that designer use
      return (inputHeight / 812.0) * screenHeight;
    }

// Get the proportionate height as per screen size
    double getProportionateScreenWidth(double inputWidth) {
      double screenWidth = width;
      // 375 is the layout width that designer use
      return (inputWidth / 375.0) * screenWidth;
    }
  
    return Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: kPrimaryGradientColor,
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/images/wave_illustration.png")),
            Text("Voice Processing System",
                style: TextStyle(fontSize: getProportionateScreenWidth(18)))
          ],
        )));
  }
}
