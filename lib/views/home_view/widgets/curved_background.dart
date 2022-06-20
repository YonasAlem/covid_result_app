import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class CurvedBackground extends StatelessWidget {
  const CurvedBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          gradient: gradient1,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
      ),
    );
  }
}
