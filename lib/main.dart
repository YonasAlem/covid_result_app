import 'package:covid_result_app/services/auth_services/auth_services.dart';
import 'package:covid_result_app/services/auth_services/auth_user.dart';
import 'package:covid_result_app/views/full_screen_qr_view.dart';
import 'package:covid_result_app/views/home_view.dart';
import 'package:covid_result_app/views/patient_register_view.dart';
import 'package:covid_result_app/views/verify_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';

import 'views/login_view.dart';
import 'views/register_view.dart';
import 'widgets/auth_views_widgets/logo_and_title.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
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
        fontFamily: 'Regular',
      ),
      home: const FirstScreenHandler(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case RegisterView.routeName:
            return PageTransition(
              child: const RegisterView(),
              type: PageTransitionType.fade,
              curve: Curves.easeIn,
              settings: settings,
            );
          case LoginView.routeName:
            return PageTransition(
              child: const LoginView(),
              type: PageTransitionType.fade,
              curve: Curves.easeOut,
              settings: settings,
            );
          case VerifyView.routeName:
            return PageTransition(
              child: const VerifyView(),
              type: PageTransitionType.rightToLeft,
              curve: Curves.easeIn,
              settings: settings,
            );
          case HomeView.routeName:
            return PageTransition(
              child: const HomeView(),
              type: PageTransitionType.leftToRight,
              curve: Curves.easeIn,
              settings: settings,
            );
          case PatientRegisterView.routeName:
            return PageTransition(
              child: const PatientRegisterView(),
              type: PageTransitionType.rightToLeft,
              curve: Curves.easeIn,
              settings: settings,
            );
          case FullScreenQRView.routeName:
            return PageTransition(
              child: const FullScreenQRView(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
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
      future: AuthServices.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final AuthUser? user = AuthServices.firebase().currentUser;
            GetStorage().remove('email');
            if (user != null) {
              if (user.isEmailVerified) {
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
                  LogoAndTitle(haveAnimation: false),
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
