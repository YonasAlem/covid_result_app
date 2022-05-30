import 'package:flutter/material.dart';

class TextWidgetSmall extends StatelessWidget {
  const TextWidgetSmall({
    Key? key,
    required this.text,
    this.fontSize,
    this.havePadding = true,
  }) : super(key: key);

  final String text;
  final double? fontSize;
  final bool havePadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: havePadding ? 10 : 0, bottom: havePadding ? 5 : 0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey,
          letterSpacing: 1,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
