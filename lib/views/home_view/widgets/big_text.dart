import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../widgets/text_widget_big.dart';

class BigText extends StatelessWidget {
  const BigText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: TextWidgetBig(
        text: text,
        color: textColor,
      ),
    );
  }
}
