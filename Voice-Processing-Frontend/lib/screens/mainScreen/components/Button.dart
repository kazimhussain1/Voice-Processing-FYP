import 'package:flutter/material.dart';

import '../../../constants.dart';


class Button extends StatelessWidget {
  const Button({
    Key key, this.text, this.press,
  }) : super(key: key);

  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
     double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;



// Get the proportionate height as per screen size
    double getProportionateScreenWidth(double inputWidth) {
      double screenWidth = width;
      // 375 is the layout width that designer use
      return (inputWidth / 375.0) * screenWidth;
    }

    return GestureDetector(
      onTap: press,
      child: Container(
          width: width * 0.58,
          height: getProportionateScreenWidth(45),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ], color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Text(text,
                  style:
                      TextStyle(fontSize: getProportionateScreenWidth(15))))),
    );
  }
}

