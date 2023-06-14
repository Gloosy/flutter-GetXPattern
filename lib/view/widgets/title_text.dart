import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class TitleText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;

  TitleText({
      super.key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.size = 0
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: 1,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto',
          fontSize:size == 0 ? Dimensions.font20 : size),
    );
  }
}
