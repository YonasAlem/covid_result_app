import 'package:covid_result_app/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  final String logoSrc = 'assets/images/logo.png';
  final String appTitle = 'Covid Result\nChecker';

  @override
  Widget build(BuildContext context) {
    return ScaffoldBackground(
      scaffold: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  logoSrc,
                  height: 80,
                ),
                const SizedBox(width: 10),
                Text(
                  appTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Black',
                    fontSize: 26,
                    letterSpacing: 1,
                    color: Colors.grey[800]!,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
