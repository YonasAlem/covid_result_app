import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

displayToast({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    textColor: Colors.white,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black45,
  );
}
