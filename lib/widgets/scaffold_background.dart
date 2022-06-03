import 'package:covid_result_app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'clipped_background.dart';

class ScaffoldBackground extends StatelessWidget {
  const ScaffoldBackground({Key? key, required this.scaffold, this.height}) : super(key: key);

  final Widget scaffold;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: Colors.white,
          alignment: Alignment.bottomCenter,
          child: ClipPath(
            clipper: ClippedBackground(),
            child: Container(
              height: height ?? 450,
              width: double.maxFinite,
              decoration: BoxDecoration(
                gradient: gradient1,
              ),
            ),
          ),
        ),
        scaffold,
      ],
    );
  }
}
