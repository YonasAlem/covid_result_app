import 'package:covid_result_app/views/home_view.dart';
import 'package:covid_result_app/views/verify_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'utils/colors.dart';
import 'views/login_view.dart';
import 'views/register_view.dart';
import 'widgets/auth_views_widgets/logo_and_title.dart';

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
      home: const FirstScreenHandler(),
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

class FirstScreenHandler extends StatelessWidget {
  const FirstScreenHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final User? user = FirebaseAuth.instance.currentUser;

            if (user != null) {
              if (user.emailVerified) {
                return const HomeView();
              } else {
                return const VerifyView();
              }
            } else {
              return const LoginView();
            }
          default:
            return Scaffold(
              body: Column(
                children: const [
                  SizedBox(height: 70),
                  LogoAndTitle(),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              ),
            );
        }
      },
    );
  }
}
