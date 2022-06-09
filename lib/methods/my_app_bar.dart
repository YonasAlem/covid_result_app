import 'package:covid_result_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar appBar({
  Color? backgroundColor,
  String? title,
  Brightness? statusBarIconBrightness,
  double? elevation,
  double? toolBarHeight,
  List<Widget>? actions,
  Widget? leading,
}) {
  return AppBar(
    elevation: elevation ?? 4,
    toolbarHeight: toolBarHeight ?? kToolbarHeight,
    backgroundColor: backgroundColor ?? Colors.white,
    leading: leading,
    title: title != null
        ? Text(
            title,
            style: TextStyle(
              letterSpacing: 1,
              fontFamily: 'Bold',
              color: backgroundColor != null ? Colors.white : textColor,
            ),
          )
        : null,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: statusBarIconBrightness ?? Brightness.light,
    ),
    actions: actions,
  );
}
