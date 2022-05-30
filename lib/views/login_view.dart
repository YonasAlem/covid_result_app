import 'package:covid_result_app/views/register_view.dart';
import 'package:covid_result_app/widgets/animated_text_widget.dart';
import 'package:covid_result_app/widgets/auth_views_widgets/logo_and_title.dart';
import 'package:covid_result_app/widgets/scaffold_background.dart';
import 'package:covid_result_app/widgets/submit_button_small.dart';
import 'package:covid_result_app/widgets/text_widget_small.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/auth_views_widgets/auth_text_field.dart';
import '../widgets/submit_button_big.dart';

class LoginView extends StatefulWidget {
  static const String routeName = '/loginview/';

  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    _password.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBackground(
      scaffold: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const LogoAndTitle(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.9),
                  // big container shadow
                  boxShadow: const [boxShadow1],
                ),
                child: _formField(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _formField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const AnimatedTextWidget(
          title1: 'Welcome back!',
          title2: 'Stay safe!',
        ),
        const SizedBox(height: 5),
        const Divider(
          indent: 2,
          endIndent: 260,
          thickness: 3,
          color: mainColor,
        ),
        const TextWidgetSmall(text: 'Email address'),
        const SizedBox(height: 5),
        AuthTextField(
          controller: _email,
          hintText: 'enter company\'s email',
        ),
        const TextWidgetSmall(text: 'Password'),
        Hero(
          tag: 'passTag',
          child: Material(
            color: Colors.transparent,
            child: AuthTextField(
              controller: _password,
              isPassword: _password.text.isEmpty ? false : true,
              hintText: 'enter your password',
            ),
          ),
        ),
        const SizedBox(height: 20),
        Hero(
          tag: 'SubmitButtonBig',
          child: SubmitButtonBig(
            onTap: () {},
            text: 'Login',
            gradient: gradient1,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidgetSmall(
              text: "Don't have an account yet? ",
              havePadding: false,
            ),
            SubmitButtonSmall(
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                RegisterView.routeName,
                (route) => false,
              ),
              context: context,
              text: 'Register.',
            )
          ],
        ),
      ],
    );
  }
}
