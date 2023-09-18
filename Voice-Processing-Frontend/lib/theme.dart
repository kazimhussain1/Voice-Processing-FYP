import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    // inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

// InputDecorationTheme inputDecorationTheme() {
//   var outlineInputBorder = OutlineInputBorder(
//     borderRadius: BorderRadius.circular(28),
//     borderSide: BorderSide(color: ),
//     gapPadding: 10,
//   );
//   return InputDecorationTheme(
//       contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
//       floatingLabelBehavior: FloatingLabelBehavior.always,
//       enabledBorder: outlineInputBorder,
//       focusedBorder: outlineInputBorder,
//       border: outlineInputBorder);
// }

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: whiteColor),
    bodyText2: TextStyle(color: whiteColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
      color: kPrimaryColor,
      centerTitle: true,
      elevation: 0,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.white),
      textTheme:
          TextTheme(headline6: TextStyle(color: whiteColor, fontSize: 18)));
}
