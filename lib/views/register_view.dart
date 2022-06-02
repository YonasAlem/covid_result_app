import 'package:covid_result_app/utils/colors.dart';
import 'package:covid_result_app/views/login_view.dart';
import 'package:covid_result_app/widgets/auth_views_widgets/auth_text_field.dart';
import 'package:covid_result_app/widgets/display_toast.dart';
import 'package:covid_result_app/widgets/scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

import '../services/auth_services/auth_exceptions.dart';
import '../services/auth_services/auth_services.dart';
import '../widgets/animated_text_widget.dart';
import '../widgets/auth_views_widgets/logo_and_title.dart';
import '../widgets/loading_widget.dart';
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

  GetStorage box = GetStorage();

  bool isLoading = false;

  @override
  void initState() {
    if (box.read('email') != null && box.read('email1') != null) {
      _email.text = box.read('email') == box.read('email1') ? box.read('email') : '';
    }
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
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white,
          ),
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
          title1: 'Create new account',
          title2: 'Keep your distance!',
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
          hintText: 'name@organization.domain',
          error: emailError,
        ),
        const TextWidgetSmall(text: 'New password'),
        AuthTextField(
          controller: _password,
          isPassword: _password.text.isEmpty ? false : true,
          hintText: 'enter your password',
          borderColor: passwordError != null ? Colors.red.withOpacity(0.5) : null,
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
            ),
          ),
        ),
        const SizedBox(height: 20),
        Hero(
          tag: 'SubmitButtonBig',
          child: SubmitButtonBig(
            onTap: isLoading
                ? () => displayToast(message: 'Please wait while loading ...')
                : _registerCompany,
            gradient: gradient1,
            child: isLoading
                ? const SpinKitCircle(color: Colors.white, size: 30)
                : const Text(
                    'Register',
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
              text: 'Already have an account? ',
              havePadding: false,
            ),
            SubmitButtonSmall(
              onTap: isLoading
                  ? () => displayToast(message: 'Please wait while loading ...')
                  : () {
                      box.write('email1', _email.text);
                      return Navigator.of(context).pushReplacementNamed(LoginView.routeName);
                    },
              text: 'Login.',
              context: context,
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _registerCompany() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      passwordError = null;
      emailError = null;
    });

    final String email = _email.text.trim().toLowerCase();
    final String password = _password.text.trim();
    final String confirm = _confirmPassword.text.trim();

    if (email.isEmpty || confirm.isEmpty || password.length != confirm.length) {
      if (email.isEmpty) setEmailErrorMessage('Email can not be empty.');

      if (confirm.isEmpty || password.isEmpty) {
        setPasswordErrorMessage('Password can not be empty.');
      } else if (password.length != confirm.length) {
        setPasswordErrorMessage("Those password didn't match. Try again.");
      }
    } else {
      try {
        setState(() => isLoading = true);
        await AuthServices.firebase().register(email: email, password: password);
        await AuthServices.firebase().sendEmailVerification();
        if (mounted) {
          turnOffLoadingWidget();
          Navigator.of(context).pushNamed(VerifyView.routeName, arguments: email);
        }
      } on EmailAlreadyInUseAuthException {
        box.write('email', _email.text);
        turnOffLoadingWidget();
        setEmailErrorMessage('The email is taken. Try another.');
      } on WeakPasswordAuthException {
        turnOffLoadingWidget();
        setPasswordErrorMessage('Use 6 characters or more for your password.');
      } on InvalidEmailAuthException {
        turnOffLoadingWidget();
        setEmailErrorMessage('The email is invalid. Try another');
      } on GenericAuthException {
        turnOffLoadingWidget();
        displayToast(message: 'Too many requests, please try again!');
      }
    }
  }

  void setPasswordErrorMessage(String message) => setState(() => passwordError = message);
  void setEmailErrorMessage(String message) => setState(() => emailError = message);
  void turnOffLoadingWidget() => setState(() => isLoading = false);
}
