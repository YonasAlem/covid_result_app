import 'dart:io';

import 'package:covid_result_app/utils/colors.dart';
import 'package:covid_result_app/widgets/home_view_widgets/qr_scanner_button.dart';
import 'package:covid_result_app/widgets/text_widget_big.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/auth_services/auth_services.dart';
import '../widgets/home_view_widgets/task_button.dart';
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
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Home view',
            style: TextStyle(
              color: textColor,
              fontFamily: 'Bold',
              letterSpacing: 1,
            ),
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: PopupMenuButton<MenuAction>(
              position: PopupMenuPosition.under,
              color: Colors.white,
              icon: Icon(
                Icons.segment,
                color: textColor,
              ),
              onSelected: popUpMenuHandler,
              itemBuilder: (context) => popUpMenuItemList,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _headerCard(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: Text(
                'Tasks',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  letterSpacing: 1,
                  fontFamily: 'Bold',
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TaskButton(
                    onTap: registerPatient,
                    color: const Color(0xFF628ec5),
                    icon: Icons.post_add,
                    title: 'Register',
                    desc: 'Create new patient record.',
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TaskButton(
                    onTap: updatePatient,
                    color: const Color(0xffb774bd),
                    icon: Icons.update_rounded,
                    title: 'Update',
                    desc: 'Alter an existing record.',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TaskButton(
                    onTap: viewPatient,
                    color: const Color(0xFFdb7634),
                    icon: Icons.view_list_rounded,
                    title: 'View All',
                    desc: 'Display all records from database.',
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TaskButton(
                    onTap: deletePatient,
                    icon: Icons.delete_outline,
                    color: const Color(0xff8866cf),
                    title: 'Delete',
                    desc: 'Remove an existing record from database.',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Find Records Using',
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                letterSpacing: 1,
                fontFamily: 'Bold',
              ),
            ),
            const SizedBox(height: 20),
            QrScannerButton(
              onTap: scanQrData,
            ),
          ],
        ),
      ),
    );
  }

  registerPatient() {}
  updatePatient() {}
  viewPatient() {}
  deletePatient() {}
  scanQrData() {}

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
