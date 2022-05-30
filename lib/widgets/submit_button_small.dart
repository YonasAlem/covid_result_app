import 'package:flutter/material.dart';

class SubmitButtonSmall extends StatelessWidget {
  const SubmitButtonSmall({Key? key, required this.context, required this.text, this.onTap})
      : super(key: key);

  final BuildContext context;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(
          letterSpacing: 1,
          color: Colors.blue,
        ),
      ),
    );
  }
}
