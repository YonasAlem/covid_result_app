import 'dart:developer';
import 'dart:io';

import 'package:covid_result_app/enums/operation_status.dart';
import 'package:covid_result_app/methods/single_list_item.dart';
import 'package:covid_result_app/methods/warning_dialog.dart';
import 'package:covid_result_app/services/db_services/database_services.dart';
import 'package:covid_result_app/utils/colors.dart';
import 'package:covid_result_app/widgets/big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../methods/display_snackbar.dart';

class QrScannerView extends StatefulWidget {
  static const String routeName = '/qrScannerView/';
  const QrScannerView({Key? key}) : super(key: key);

  @override
  State<QrScannerView> createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  final qrKey = GlobalKey(debugLabel: "QR");

  QRViewController? controller;

  Barcode? barcode;

  bool flashLightState = false;
  bool frontCameraState = false;

  @override
  void reassemble() async {
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            overlay: QrScannerOverlayShape(
              borderRadius: 20,
              borderWidth: 10,
              borderColor: mainColor,
              cutOutSize: MediaQuery.of(context).size.width * 0.8,
            ),
            onQRViewCreated: (QRViewController controller) async {
              controller.resumeCamera();
              setState(() => this.controller = controller);
              controller.scannedDataStream.listen((event) {
                setState(() => barcode = event);
              });
            },
          ),
          Positioned(
            bottom: 170,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                smallButton(
                    onTap: () {
                      setState(() => frontCameraState = !frontCameraState);
                      return controller!.flipCamera();
                    },
                    text: "Flip Camera",
                    iconData: frontCameraState
                        ? Icons.flip_camera_ios_outlined
                        : Icons.flip_camera_ios_rounded,
                    color: frontCameraState ? const Color(0xFFdb7634) : null),
                const SizedBox(width: 20),
                smallButton(
                  onTap: () {
                    setState(() => flashLightState = !flashLightState);
                    return controller!.toggleFlash();
                  },
                  text: "Flash Light",
                  iconData: flashLightState ? Icons.flashlight_on : Icons.flashlight_off,
                  color: flashLightState ? const Color(0xFFdb7634) : null,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              children: [
                if (barcode != null)
                  BigButton(
                    onPressed: () async {
                      await EasyLoading.show(status: "Finding Patient");
                      try {
                        final result = await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                          var idNumber = barcode?.code?.split("/").last ?? '1212';
                          var result = await DatabaseServices.mongoDb().singlePatientData(
                            idNumber: idNumber,
                          );
                          if (result == OperationStatus.failed) {
                            await EasyLoading.showError('Patient not found');
                            setState(() {
                              barcode = null;
                            });
                          } else {
                            EasyLoading.dismiss();
                            var shouldDisplayDetail = await warningDialog(
                              context: context,
                              boxTitle: "Patient found: ",
                              boxDescription: "Do you want to see the detail?",
                              cancleText: "Close",
                              okText: "Details",
                            );
                            if (shouldDisplayDetail && mounted) {
                              singleListItem(context, patient: result);
                              setState(() {
                                barcode = null;
                              });
                            } else {
                              setState(() {
                                barcode = null;
                              });
                            }
                          }
                        }
                      } on SocketException catch (_) {
                        setState(() => barcode = null);
                        displaySnackBar(
                          context: context,
                          text: 'No internet connection found!',
                          backgroundColor: Colors.red[300],
                        );
                      }
                    },
                    text: const Text(
                      'Click to see the data',
                      style: TextStyle(color: Colors.white),
                    ),
                    buttonColor: const Color(0xFF243a54),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column smallButton({
    required Function()? onTap,
    required String text,
    required IconData iconData,
    Color? color,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color ?? const Color(0xFF243a54),
            borderRadius: BorderRadius.circular(30),
          ),
          child: IconButton(
            onPressed: onTap,
            icon: Icon(iconData, color: Colors.white),
          ),
        ),
        SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(color: Colors.white, letterSpacing: 1),
        ),
      ],
    );
  }
}
