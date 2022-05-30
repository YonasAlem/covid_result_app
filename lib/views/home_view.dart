import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  static const String routeName = '/homeview/';

  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home view'),
      ),
    );
  }
}
