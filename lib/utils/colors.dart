import 'package:flutter/material.dart';

LinearGradient gradient1 = LinearGradient(
  colors: [Colors.blue[800]!, Colors.blue, Colors.cyan],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);

const mainColor = Colors.blue;
const Color secondaryColor = Colors.cyan;

const BoxShadow boxShadow1 = BoxShadow(
  color: Colors.black26,
  blurRadius: 10,
  spreadRadius: 1,
  offset: Offset(0, 10),
);
