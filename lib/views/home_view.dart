import 'dart:io';

import 'package:covid_result_app/utils/colors.dart';
import 'package:covid_result_app/widgets/text_widget_big.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/auth_services/auth_services.dart';
import '../widgets/warning_dialog.dart';
import 'login_view.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/homeview/';

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

enum MenuAction { logOut, exit }

class _HomeViewState extends State<HomeView> {
  List<PopupMenuItem<MenuAction>> popUpMenuItemList = [
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
    PopupMenuItem(
      value: MenuAction.exit,
      child: Row(
        children: [
          const Icon(Icons.close, color: Colors.grey),
          const SizedBox(width: 5),
          Text(
            'Exit app',
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    ),
  ];

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
            onSelected: popUpMenuHandler,
            itemBuilder: (context) => popUpMenuItemList,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _headerCard(),
          ],
        ),
      ),
    );
  }

  Future<void> popUpMenuHandler(value) async {
    switch (value) {
      case MenuAction.logOut:
        final shouldLogout = await warningDialog(
          context: context,
          boxTitle: 'Logging out',
          boxDescription: 'Are you sure you want to logout?',
          cancleText: 'Cancel',
          okText: 'Logout',
        );
        if (shouldLogout) {
          await AuthServices.firebase().logout();
          if (mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              LoginView.routeName,
              (route) => false,
            );
          }
        }
        break;
      case MenuAction.exit:
        final shouldExit = await warningDialog(
          context: context,
          boxTitle: 'Exit the app',
          boxDescription: 'Are you sure you want to quit the app?',
          cancleText: 'Cancel',
          okText: 'Exit',
        );
        if (shouldExit) exit(0);
    }
  }

  Container _headerCard() {
    return Container(
      height: 120,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: gradient1,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [boxShadow2],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 10),
          const TextWidgetBig(
            text: 'Attention!',
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              'This product should be used only by proffesionals, specially for health care centers.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[200],
                height: 1.3,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
