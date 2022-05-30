import 'package:flutter/material.dart';

class TextWidgetBig extends StatelessWidget {
  const TextWidgetBig({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        letterSpacing: 1,
        fontSize: 22,
        fontFamily: 'Bold',
      ),
    );
  }
}
