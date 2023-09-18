import 'package:flutter/material.dart';

import '../../../constants.dart';

class ButtonContainer extends StatelessWidget {
  const ButtonContainer(
      {Key key,
      this.height,
      this.width,
      this.iconSize,
      this.color,
      this.icon,
      this.gradient,
      this.onTap})
      : super(key: key);
  final double height;
  final double width;
  final Color color;
  final double iconSize;
  final IconData icon;
  final LinearGradient gradient;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: gradient,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 9), // changes position of shadow
              ),
            ],
          ),
          child: ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: onTap,
                  child: Center(
                      child: Icon(icon, size: iconSize, color: whiteColor))),
            ),
          ),
    );
  }
}
