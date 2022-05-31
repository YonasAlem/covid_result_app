import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../services/auth_services/auth_services.dart';
import '../utils/colors.dart';
import '../widgets/loading_widget.dart';
import 'home_view.dart';
import 'login_view.dart';

class VerifyView extends StatefulWidget {
  static const String routeName = '/verify/';

  const VerifyView({Key? key}) : super(key: key);

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  bool isVerified = false;
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 2), autoCheckEmailVerification);
    super.initState();
  }

  autoCheckEmailVerification(timer) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    await currentUser?.reload();
    if (currentUser?.emailVerified ?? false) {
      timer.cancel();
      setState(() => isVerified = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: isVerified ? const SizedBox() : BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: SvgPicture.asset(
              'assets/images/verify.svg',
              height: 200,
              width: 100,
              color: isVerified ? Colors.green : mainColor,
            ),
          ),
          Text(
            isVerified ? 'Verification Success!' : 'Waiting for verification.',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: isVerified ? Colors.green : Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              isVerified
                  ? 'the email verification was success. click the below button to go to the homepage.'
                  : 'We sent you an email verification link to. Please open the link and verify your email address.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 30),
          if (!isVerified)
            const LoadingWidget(
              color: mainColor,
              title: 'Waiting',
            )
          else
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          const SizedBox(height: 40),
          if (isVerified == false)
            const Text(
              'If you did not received an email click below.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          if (isVerified == false)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    await AuthServices.firebase().sendEmailVerification();
                  },
                  child: const Text('Send email again.'),
                ),
                const Text('  OR  '),
                TextButton(
                  onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginView.routeName,
                    (route) => false,
                  ),
                  child: const Text('Logout.'),
                ),
              ],
            ),
          if (isVerified)
            TextButton(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                HomeView.routeName,
                (route) => false,
              ),
              child: const Text('Goto HomePage >>>'),
            ),
        ],
      ),
    );
  }
}
