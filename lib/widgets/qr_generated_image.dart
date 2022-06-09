import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../utils/colors.dart';

class QrGeneratedImage extends StatelessWidget {
  const QrGeneratedImage({
    Key? key,
    required this.qrDataHolder,
    required this.fullName,
  }) : super(key: key);

  final String qrDataHolder;
  final String fullName;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrettyQr(
            size: 300,
            data: qrDataHolder,
            roundEdges: true,
            errorCorrectLevel: QrErrorCorrectLevel.M,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'FULL NAME:  ',
                style: TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 1),
              ),
              Text(
                fullName,
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 1,
                  color: textColor,
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  fontFamily: 'Bold',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
