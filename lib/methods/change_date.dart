import 'package:flutter/material.dart';

changeDate({required BuildContext context}) async {
  final DateTime now = DateTime.now();
  final DateTime? selected = await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: DateTime(2010),
    lastDate: DateTime(2025),
  );
  if (selected != null && selected != now) {
    return "${selected.day}-${selected.month}-${selected.year}";
  }
}
