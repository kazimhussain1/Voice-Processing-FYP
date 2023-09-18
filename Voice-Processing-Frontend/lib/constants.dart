import './size_config.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF0096bf);
const kPrimaryLight = Color(0xFF242423);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
  colors: [Color(0xFF0087ac), Color(0xFF6adfff)],
);

const kSecondaryGradientColor = LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
  stops: [0.2,1.0],
  colors: [Color(0xFFFB7C85),Color(0xFFFF27BF)],
);

const kGreyGradientColor = LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
  stops: [0.2,1.0],
  colors: [Colors.grey,Colors.grey],
);

const whiteColor = Colors.white;
// const cardColor = Color(0xFF1b3045);
// const lightCardColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xFF2A3A49), Color(0xFF1b3045)],
// );
// const kPrimaryTransparentColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xEAD6B065), Color(0xEEA87F4A)],
// );

final headingStyle = TextStyle(
    fontSize: getProportionateScreenWidth(28),
    color: Colors.black,
    fontWeight: FontWeight.bold,
    height: 1.5);

// final otpInputDecoration = InputDecoration(
//   contentPadding:
//       EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
//   enabledBorder: outlineInputBorder(),
//   focusedBorder: outlineInputBorder(),
//   border: outlineInputBorder(),
// );

// OutlineInputBorder outlineInputBorder() {
//   return OutlineInputBorder(
//     borderRadius: BorderRadius.circular(15),
//     borderSide: BorderSide(color: kTextColor),
//   );
// }
