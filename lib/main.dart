import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'utils/colors.dart';
import 'views/login_view.dart';
import 'views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid Result',
      theme: ThemeData(
        primarySwatch: mainColor,
        fontFamily: 'Regular',
      ),
      home: const RegisterView(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case RegisterView.routeName:
            return PageTransition(
              child: const RegisterView(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              settings: settings,
            );
          case LoginView.routeName:
            return PageTransition(
              child: const LoginView(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              settings: settings,
            );
        }
      },
    );
  }
}
