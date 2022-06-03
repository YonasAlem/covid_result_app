import 'package:flutter/material.dart';

class QrScannerButton extends StatelessWidget {
  const QrScannerButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF243a54),
      borderRadius: BorderRadius.circular(15),
      shadowColor: Colors.black,
      elevation: 10,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 120,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'QR Scanner',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        letterSpacing: 1,
                        fontFamily: 'Foo-Bold',
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Scan patient\'s record by using camera or file.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        letterSpacing: 1,
                        fontFamily: 'Foo-Bold',
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
