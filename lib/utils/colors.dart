import 'package:flutter/material.dart';

LinearGradient gradient1 = LinearGradient(
  colors: [Colors.blue[800]!, Colors.blue, Colors.cyan],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);

final mainColor = Colors.blue[800]!;
const Color secondaryColor = Colors.cyan;
Color textColor = Colors.grey[800]!;

const BoxShadow boxShadow1 = BoxShadow(
  color: Colors.black26,
  blurRadius: 10,
  spreadRadius: 1,
  offset: Offset(0, 10),
);
