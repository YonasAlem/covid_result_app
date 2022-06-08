import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../utils/colors.dart';

class QrGeneratedImage extends StatelessWidget {
  const QrGeneratedImage({
    Key? key,
    required this.qrDataHolder,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);

  final String qrDataHolder;
  final String firstName;
  final String lastName;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrettyQr(
            size: 150,
            data: qrDataHolder,
            roundEdges: true,
            errorCorrectLevel: QrErrorCorrectLevel.M,
          ),
          const SizedBox(height: 15),
          const Text(
            'FULL NAME:',
            style: TextStyle(
              color: Colors.grey,
              letterSpacing: 1,
              fontSize: 12,
              decoration: TextDecoration.underline,
            ),
          ),
          Text(
            '${firstName.trim().toUpperCase()} ${lastName.trim().toUpperCase()}',
            style: TextStyle(
              fontSize: 16,
              letterSpacing: 1,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
