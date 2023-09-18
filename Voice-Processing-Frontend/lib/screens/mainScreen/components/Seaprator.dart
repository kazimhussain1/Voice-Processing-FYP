import 'package:flutter/material.dart';



class Seperator extends StatelessWidget {
  const Seperator({
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
  
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          width: getProportionateScreenWidth(30),
          height: getProportionateScreenWidth(1),
          color: Colors.grey),
      SizedBox(width: getProportionateScreenWidth(5)),
      Text("OR", style: TextStyle(color: Colors.grey)),
      SizedBox(width: getProportionateScreenWidth(5)),
      Container(
          width: getProportionateScreenWidth(30),
          height: getProportionateScreenWidth(1),
          color: Colors.grey)
    ]);
  }
}
