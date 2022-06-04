import 'package:flutter/material.dart';

import '../utils/colors.dart';

Future<bool> warningDialog({
  required BuildContext context,
  required String boxTitle,
  required String boxDescription,
  required String cancleText,
  required String okText,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(boxTitle),
        content: Text(boxDescription),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              cancleText,
              style: const TextStyle(color: secondaryColor),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              okText,
              style: TextStyle(color: Colors.red.shade800),
            ),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
