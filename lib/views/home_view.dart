import 'package:covid_result_app/utils/colors.dart';
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
      appBar: AppBar(
        title: const Text('Home view'),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: mainColor,
          statusBarIconBrightness: Brightness.light,
        ),
        actions: [
          PopupMenuButton<MenuAction>(
            position: PopupMenuPosition.under,
            color: Colors.white,
            icon: const Icon(Icons.segment, color: Colors.black),
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logOut:
                  final shouldLogout = await showLogoutDialog();
                  if (shouldLogout) {
                    AuthServices.firebase().logout();
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
                    children: const [
                      Icon(Icons.logout, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        'Logout',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }

  Future<bool> showLogoutDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign out'),
          content: const Text('Are you sure you want to sign out?'),
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
