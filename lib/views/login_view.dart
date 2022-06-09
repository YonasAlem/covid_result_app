import 'package:covid_result_app/enums/loading_type.dart';
import 'package:covid_result_app/methods/my_app_bar.dart';
import 'package:covid_result_app/views/register_view.dart';
import 'package:covid_result_app/widgets/animated_text_widget.dart';
import 'package:covid_result_app/widgets/auth_views_widgets/logo_and_title.dart';
import 'package:covid_result_app/methods/display_toast.dart';
import 'package:covid_result_app/widgets/scaffold_background.dart';
import 'package:covid_result_app/widgets/submit_button_small.dart';
import 'package:covid_result_app/widgets/text_widget_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_storage/get_storage.dart';

import '../services/auth_services/auth_exceptions.dart';
import '../services/auth_services/auth_services.dart';
import '../utils/colors.dart';
import '../widgets/auth_views_widgets/auth_text_field.dart';
import '../widgets/submit_button_big.dart';
import 'home_view.dart';
import 'verify_view.dart';

class LoginView extends StatefulWidget {
  static const String routeName = '/loginview/';

  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  String? emailError;
  String? passwordError;

  Enum? loadingType;

  GetStorage box = GetStorage();

  @override
  void initState() {
    if (box.read('email') != null && box.read('email1') != null) {
      _email.text = box.read('email') == box.read('email1') ? box.read('email') : '';
    }
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
        appBar: appBar(
          toolBarHeight: 0,
          elevation: 0,
          statusBarIconBrightness: Brightness.dark,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const LogoAndTitle(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.95),
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
          color: secondaryColor,
        ),
        const TextWidgetSmall(text: 'Email address'),
        AuthTextField(
          controller: _email,
          hintText: 'enter company\'s email',
          error: emailError,
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
              error: passwordError,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Hero(
          tag: 'SubmitButtonBig',
          child: SubmitButtonBig(
            onTap: loadingType == LoadingType.loginButton
                ? () => displayToast(message: 'Please wait while loading ...')
                : _loginCompany,
            gradient: gradient1,
            child: loadingType == LoadingType.loginButton
                ? const SpinKitCircle(color: Colors.white, size: 30)
                : const Text(
                    'Login',
                    style: TextStyle(
                      letterSpacing: 1,
                      fontFamily: 'Bold',
                    ),
                  ),
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
              onTap: loadingType == LoadingType.loginButton
                  ? () => displayToast(message: 'Please wait while loading ...')
                  : () {
                      box.write('email1', _email.text);
                      return Navigator.of(context).pushReplacementNamed(
                        RegisterView.routeName,
                      );
                    },
              context: context,
              text: 'Register.',
            )
          ],
        ),
      ],
    );
  }

  Future<void> _loginCompany() async {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      passwordError = null;
      emailError = null;
    });

    final String email = _email.text.trim().toLowerCase();
    final String password = _password.text.trim();

    if (email.isEmpty || password.isEmpty) {
      if (email.isEmpty) setEmailErrorMessage('Email can not be empty.');
      if (password.isEmpty) setPasswordErrorMessage('Password can not be empty.');
    } else {
      try {
        changeLoadingState(state: true);
        await AuthServices.firebase().login(email: email, password: password);
        final currentUser = AuthServices.firebase().currentUser;
        if (currentUser?.isEmailVerified ?? false) {
          if (mounted) {
            changeLoadingState(state: false);
            Navigator.of(context).pushNamedAndRemoveUntil(
              HomeView.routeName,
              (route) => false,
            );
          }
        } else {
          if (mounted) {
            changeLoadingState(state: false);
            Navigator.of(context).pushNamed(VerifyView.routeName);
          }
        }
      } on UserNotFoundAuthException {
        box.write('email', _email.text);
        changeLoadingState(state: false);
        setEmailErrorMessage("Couldn't find your account.");
      } on WrongPasswordAuthException {
        changeLoadingState(state: false);
        setPasswordErrorMessage('Wrong password, Please try again!');
      } on GenericAuthException {
        changeLoadingState(state: false);
        displayToast(message: 'Too many requests, please try again!');
      }
    }
  }

  void setPasswordErrorMessage(String message) => setState(() => passwordError = message);
  void setEmailErrorMessage(String message) => setState(() => emailError = message);

  void changeLoadingState({required bool state}) {
    if (state == true) loadingType = LoadingType.loginButton;
    if (state == false) loadingType = null;
    setState(() {});
  }
}
