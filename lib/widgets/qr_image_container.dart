import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../views/full_screen_qr_view.dart';

class QrImageContainerFull extends StatelessWidget {
  const QrImageContainerFull({
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
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        FullScreenQRView.routeName,
        arguments: [qrDataHolder, firstName, lastName],
      ),
      child: Hero(
        tag: 'qr',
        child: Column(
          children: [
            PrettyQr(
              size: 150,
              data: qrDataHolder,
              roundEdges: true,
              errorCorrectLevel: QrErrorCorrectLevel.M,
            ),
          ],
        ),
      ),
    );
  }
}
