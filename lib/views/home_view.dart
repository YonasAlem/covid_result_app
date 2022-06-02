import 'package:covid_result_app/utils/colors.dart';
import 'package:covid_result_app/widgets/text_widget_big.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/auth_services/auth_services.dart';
import 'login_view.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/homeview/';

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

enum MenuAction { logOut }

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Home view',
          style: TextStyle(color: textColor),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        actions: [
          PopupMenuButton<MenuAction>(
            position: PopupMenuPosition.under,
            color: Colors.white,
            icon: Icon(
              Icons.segment,
              color: textColor,
            ),
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logOut:
                  final shouldLogout = await showLogoutDialog();
                  if (shouldLogout) {
                    await AuthServices.firebase().logout();
                    if (mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginView.routeName,
                        (route) => false,
                      );
                    }
                  }
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: MenuAction.logOut,
                  child: Row(
                    children: [
                      const Icon(Icons.logout, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text(
                        'Logout',
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              height: 120,
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                gradient: gradient1,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  SizedBox(height: 10),
                  TextWidgetBig(
                    text: 'Attention!',
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Text(
                      'This product should be used only by proffesionals, specially for health care centers.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        height: 1.3,
                        fontSize: 12,
                        letterSpacing: 1,
                        fontFamily: 'Foo-Bold',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> showLogoutDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logging out'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: secondaryColor),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.red.shade800),
              ),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }
}
