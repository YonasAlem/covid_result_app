import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AnimatedTextWidget extends StatelessWidget {
  const AnimatedTextWidget({Key? key, required this.title1, this.title2}) : super(key: key);

  final String title1;
  final String? title2;

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        ColorizeAnimatedText(
          title1,
          textStyle: const TextStyle(
            fontSize: 22,
            fontFamily: 'Bold',
            letterSpacing: 1,
          ),
          colors: [Colors.grey[700]!, mainColor, secondaryColor],
        ),
        if (title2 != null)
          ColorizeAnimatedText(
            title2!,
            textStyle: const TextStyle(
              fontSize: 22,
              fontFamily: 'Bold',
              letterSpacing: 1,
            ),
            colors: [Colors.grey[700]!, mainColor, secondaryColor],
          ),
      ],
    );
  }
}
