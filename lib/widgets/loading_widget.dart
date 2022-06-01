import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    required this.text,
    this.width = 95,
    this.bgColor = Colors.white,
    this.iconColor = Colors.blue,
  }) : super(key: key);

  final String text;
  final double width;
  final Color bgColor;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: width,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [boxShadow1],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitCircle(color: iconColor),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
