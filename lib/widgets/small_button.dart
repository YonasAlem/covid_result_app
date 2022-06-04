import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({Key? key, this.onPressed, required this.iconData}) : super(key: key);

  final Function()? onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(15),
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
        child: Icon(iconData),
      ),
    );
  }
}
