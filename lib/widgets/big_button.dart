import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  const BigButton({
    Key? key,
    this.onPressed,
    required this.text,
    required this.buttonColor,
  }) : super(key: key);

  final Function()? onPressed;
  final Widget text;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: text,
      ),
    );
  }
}
