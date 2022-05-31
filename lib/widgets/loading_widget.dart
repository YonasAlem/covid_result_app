import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.color,
    this.title,
  }) : super(key: key);

  final Color? color;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpinKitThreeInOut(
          color: color ?? Colors.white,
          size: 40,
        ),
        Text(
          title ?? 'Loading',
          style: TextStyle(
            letterSpacing: 1,
            fontFamily: 'Foo-Bold',
            fontSize: 16,
            color: color ?? Colors.white,
          ),
        ),
      ],
    );
  }
}
