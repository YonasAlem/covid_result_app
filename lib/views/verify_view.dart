import 'package:covid_result_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerifyView extends StatelessWidget {
  static const String routeName = '/verifyview/';

  const VerifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify view'),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: mainColor,
        ),
      ),
    );
  }
}
