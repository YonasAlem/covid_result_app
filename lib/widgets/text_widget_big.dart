import 'package:covid_result_app/utils/colors.dart';
import 'package:flutter/material.dart';

class TextWidgetBig extends StatelessWidget {
  const TextWidgetBig({Key? key, required this.text, this.color}) : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        letterSpacing: 1,
        fontSize: 20,
        fontFamily: 'Bold',
        color: color ?? textColor,
      ),
    );
  }
}
