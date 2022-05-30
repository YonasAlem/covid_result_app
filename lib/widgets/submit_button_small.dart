import 'package:covid_result_app/utils/colors.dart';
import 'package:flutter/material.dart';

class SubmitButtonSmall extends StatelessWidget {
  const SubmitButtonSmall({
    Key? key,
    required this.context,
    required this.text,
    this.onTap,
    this.color,
  }) : super(key: key);

  final BuildContext context;
  final String text;
  final Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          letterSpacing: 1,
          color: color ?? mainColor,
        ),
      ),
    );
  }
}
