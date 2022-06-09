import 'package:covid_result_app/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../views/full_screen_qr_view.dart';

class QrImageContainerFull extends StatelessWidget {
  const QrImageContainerFull({
    Key? key,
    required this.qrDataHolder,
    required this.patientModel,
  }) : super(key: key);

  final String qrDataHolder;
  final PatientModel patientModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Navigator.of(context).pushNamed(
          FullScreenQRView.routeName,
          arguments: [qrDataHolder, patientModel],
        );
      },
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
