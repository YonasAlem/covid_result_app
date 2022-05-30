import 'package:covid_result_app/utils/colors.dart';
import 'package:covid_result_app/views/login_view.dart';
import 'package:covid_result_app/widgets/auth_text_field.dart';
import 'package:covid_result_app/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';

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
                      blurRadius: 15,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidgetSmall(text: 'Already have an account? '),
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
              text: 'Login Here.',
              context: context,
            ),
          ],
        ),
      ],
    );
  }
}

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

class TextWidgetBig extends StatelessWidget {
  const TextWidgetBig({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        letterSpacing: 1,
        fontSize: 22,
        fontFamily: 'Bold',
      ),
    );
  }
}

class SubmitButtonSmall extends StatelessWidget {
  const SubmitButtonSmall({Key? key, required this.context, required this.text, this.onTap})
      : super(key: key);

  final BuildContext context;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(
          letterSpacing: 1,
          color: Colors.blue,
        ),
      ),
    );
  }
}

class SubmitButtonBig extends StatelessWidget {
  const SubmitButtonBig({Key? key, this.gradient, this.color, required this.text, this.onTap})
      : super(key: key);

  final LinearGradient? gradient;
  final Color? color;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
        gradient: gradient,
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            letterSpacing: 1,
            fontFamily: 'Bold',
          ),
        ),
      ),
    );
  }
}

class TextWidgetSmall extends StatelessWidget {
  const TextWidgetSmall({Key? key, required this.text, this.fontSize}) : super(key: key);

  final String text;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey,
          letterSpacing: 1,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
