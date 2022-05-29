import 'package:covid_result_app/utils/colors.dart';
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
              const SizedBox(height: 80),
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
              ),
              const SizedBox(height: 70),
              Container(
                padding: const EdgeInsets.all(20),
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
        const Text(
          'Create new account',
          style: TextStyle(
            letterSpacing: 1,
            fontSize: 22,
            fontFamily: 'Bold',
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Email address',
          style: TextStyle(
            color: Colors.grey,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 5),
        AuthTextField(
          controller: _email,
          hintText: 'name@organization.domain',
        ),
        const SizedBox(height: 10),
        const Text(
          'New password',
          style: TextStyle(
            color: Colors.grey,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 5),
        AuthTextField(
          controller: _password,
          isPassword: _password.text.isEmpty ? false : true,
        ),
        const SizedBox(height: 10),
        const Text(
          'Confirm password',
          style: TextStyle(
            color: Colors.grey,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 5),
        AuthTextField(
          controller: _confirmPassword,
          isPassword: _confirmPassword.text.isEmpty ? false : true,
        ),
        const SizedBox(height: 20),
        Container(
          height: 48,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: gradient1,
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
            child: const Text(
              'Register',
              style: TextStyle(
                letterSpacing: 1,
                fontFamily: 'Bold',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
