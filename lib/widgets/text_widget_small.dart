import 'package:flutter/material.dart';

class TextWidgetSmall extends StatelessWidget {
  const TextWidgetSmall({Key? key, required this.text, this.fontSize}) : super(key: key);

  final String text;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
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
