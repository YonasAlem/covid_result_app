import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;

import 'clipped_background.dart';

class ScaffoldBackground extends StatelessWidget {
  const ScaffoldBackground({Key? key, required this.scaffold}) : super(key: key);

  final Widget scaffold;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.blue,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
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
              height: 450,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.cyan,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
          ),
        ),
        scaffold,
      ],
    );
  }
}
