import 'package:flutter/material.dart';

class LogoAndTitle extends StatelessWidget {
  const LogoAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, bottom: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 80,
          ),
          const SizedBox(width: 10),
          Text(
            'Covid Result\nChecker',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Black',
              fontSize: 26,
              letterSpacing: 1,
              color: Colors.grey[800]!,
            ),
          ),
        ],
      ),
    );
  }
}
