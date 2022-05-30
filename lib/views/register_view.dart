import 'package:covid_result_app/utils/colors.dart';
import 'package:covid_result_app/views/login_view.dart';
import 'package:covid_result_app/widgets/auth_views_widgets/auth_text_field.dart';
import 'package:covid_result_app/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';

import '../services/auth_services/auth_exceptions.dart';
import '../services/auth_services/auth_services.dart';
import '../widgets/animated_text_widget.dart';
import '../widgets/auth_views_widgets/logo_and_title.dart';
import '../widgets/submit_button_big.dart';
import '../widgets/submit_button_small.dart';
import '../widgets/text_widget_small.dart';
import 'verify_view.dart';

class RegisterView extends StatefulWidget {
  static const String routeName = '/registerview/';

  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  String? emailError;
  String? passwordError;

  final formKey = GlobalKey<FormState>();

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

  Form _formField() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const AnimatedTextWidget(
            title1: 'Create new account',
            title2: 'Keep your distance!',
          ),
          const SizedBox(height: 5),
          const Divider(
            indent: 2,
            endIndent: 260,
            thickness: 3,
            color: mainColor,
          ),
          const TextWidgetSmall(text: 'Email address'),
          AuthTextField(
            controller: _email,
            hintText: 'name@organization.domain',
            error: emailError,
            validator: (message) {
              if (_email.text.isEmpty) {
                return 'Email can not be empty.';
              } else if (emailError != null) {
                return emailError;
              } else {
                return null;
              }
            },
          ),
          const TextWidgetSmall(text: 'New password'),
          AuthTextField(
            controller: _password,
            isPassword: _password.text.isEmpty ? false : true,
            hintText: 'enter your password',
            error: passwordError != null ? '' : null,
          ),
          const TextWidgetSmall(text: 'Confirm password'),
          Hero(
            tag: 'passTag',
            child: Material(
              color: Colors.transparent,
              child: AuthTextField(
                controller: _confirmPassword,
                isPassword: _confirmPassword.text.isEmpty ? false : true,
                hintText: 'repeat your password',
                error: passwordError,
                validator: (message) {
                  if (_confirmPassword.text.isEmpty) {
                    return 'Password can not be empty.';
                  } else if (_password.text.length != _confirmPassword.text.length) {
                    return "Those password didn't match. Try again.";
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Hero(
            tag: 'SubmitButtonBig',
            child: SubmitButtonBig(
              onTap: _registerCompany,
              text: 'Register',
              gradient: gradient1,
            ),
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
                onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginView.routeName,
                  (route) => false,
                ),
                text: 'Login.',
                context: context,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _registerCompany() async {
    FocusManager.instance.primaryFocus?.unfocus();

    passwordError = null;
    emailError = null;

    var val = formKey.currentState!.validate();

    if (val) {
      try {
        final String email = _email.text.trim().toLowerCase();
        final String password = _password.text.trim().toLowerCase();

        await AuthServices.firebase().register(email: email, password: password);
        await AuthServices.firebase().sendEmailVerification();

        if (mounted) Navigator.of(context).pushNamed(VerifyView.routeName);
      } on WeakPasswordAuthException {
        setState(() => passwordError = 'Weak password');
      } on EmailAlreadyInUseAuthException {
        setState(() => emailError = 'The email is taken. Try another.');
      } on InvalidEmailAuthException {
        setState(() => emailError = 'The email is invalid. Try another');
      } on GenericAuthException {
        setState(() => passwordError = 'Something happend, Please try again!');
      }
    }
  }
}
