import 'package:flutter/material.dart';

class QrImageContainerEmpty extends StatelessWidget {
  const QrImageContainerEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.qr_code,
            color: Colors.grey.withOpacity(0.5),
            size: 50,
          ),
          const SizedBox(height: 8),
          const Text(
            'Generating...',
            style: TextStyle(
              letterSpacing: 1,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
