import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class SubText extends StatelessWidget {
  Color? color;
  final String text;
  double size;

  double height;
  SubText(
      {super.key,
        this.color = const Color(0xFF8f837f),
        required this.text,
        this.size = 0,
        this.height = 1.2});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          height: height,
          fontFamily: 'Roboto',
          fontSize: size == 0 ? Dimensions.font12 : size),
    );
  }
}
