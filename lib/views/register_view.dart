import 'package:covid_result_app/utils/colors.dart';
import 'package:covid_result_app/views/login_view.dart';
import 'package:covid_result_app/widgets/auth_views_widgets/auth_text_field.dart';
import 'package:covid_result_app/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_views_widgets/logo_and_title.dart';
import '../widgets/submit_button_big.dart';
import '../widgets/submit_button_small.dart';
import '../widgets/text_widget_big.dart';
import '../widgets/text_widget_small.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final String logoSrc = 'assets/images/logo.png';
  final String appTitle = 'Covid Result\nChecker';

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  void initState() {
    _password.addListener(() => setState(() {}));
    _confirmPassword.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();

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
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(0, 10),
                    ),
                  ],
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
        const TextWidgetBig(text: 'Create new account'),
        const SizedBox(height: 5),
        const Divider(
          indent: 2,
          endIndent: 260,
          thickness: 3,
          color: Colors.blue,
        ),
        const TextWidgetSmall(text: 'Email address'),
        AuthTextField(
          controller: _email,
          hintText: 'name@organization.domain',
        ),
        const TextWidgetSmall(text: 'New password'),
        AuthTextField(
          controller: _password,
          isPassword: _password.text.isEmpty ? false : true,
        ),
        const TextWidgetSmall(text: 'Confirm password'),
        AuthTextField(
          controller: _confirmPassword,
          isPassword: _confirmPassword.text.isEmpty ? false : true,
        ),
        const SizedBox(height: 20),
        SubmitButtonBig(
          onTap: () {},
          text: 'Register',
          gradient: gradient1,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidgetSmall(
              text: 'Already have an account? ',
              havePadding: false,
            ),
            SubmitButtonSmall(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginView();
                    },
                  ),
                  (route) => false,
                );
              },
              text: 'Login.',
              context: context,
            ),
          ],
        ),
      ],
    );
  }
}
