import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

displayToast({required String message, Color? color, ToastGravity? gravity}) {
  Fluttertoast.showToast(
    msg: message,
    textColor: Colors.white,
    gravity: gravity ?? ToastGravity.BOTTOM,
    backgroundColor: color ?? Colors.black54,
  );
}
