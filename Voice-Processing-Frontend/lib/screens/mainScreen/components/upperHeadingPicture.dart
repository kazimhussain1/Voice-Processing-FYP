import 'package:flutter/material.dart';

import '../../../constants.dart';

class UpperPictureHeading extends StatelessWidget {
  const UpperPictureHeading({
    Key key,
  }) : super(key: key);

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
    return Container(
        width: double.infinity,
        child: Column(children: [
          Image(image: AssetImage("assets/images/welcome_cats.png")),
          Text("Welcome to the Voice\n Processing System",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold))
        ]));
  }
}
