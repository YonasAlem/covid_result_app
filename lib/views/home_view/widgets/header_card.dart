import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../widgets/text_widget_big.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: gradient1,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [boxShadow2],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 10),
          const TextWidgetBig(
            text: 'Attention!',
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              'This product should be used only by proffesionals, specially for health care centers.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[200],
                height: 1.3,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
