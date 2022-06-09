import 'package:flutter/material.dart';

displaySnackBar({
  required BuildContext context,
  required String text,
  Color? backgroundColor,
  IconData? iconData,
}) {
  return ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor ?? Colors.black45,
        margin: const EdgeInsets.only(bottom: 20, left: 30, right: 30),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        content: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: Text(text, textAlign: TextAlign.center),
            ),
            IconButton(
              onPressed: () => ScaffoldMessenger.of(context).clearSnackBars(),
              padding: const EdgeInsets.symmetric(horizontal: 7),
              constraints: const BoxConstraints(),
              icon: Icon(
                iconData ?? Icons.close,
                color: backgroundColor != null ? Colors.white : Colors.red[300],
              ),
            ),
          ],
        ),
      ),
    );
}
