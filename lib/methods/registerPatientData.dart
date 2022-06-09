import 'dart:io';

import 'package:covid_result_app/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../enums/operation_status.dart';
import '../services/db_services/database_services.dart';
import 'display_snackbar.dart';

Future<void> registerPatientData(
  context, {
  required String qrDataHolder,
  required PatientModel patientModel,
}) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      await EasyLoading.show(status: 'Saving patient data');

      OperationStatus newResult = await DatabaseServices.mongoDb().registerPatient(
        patientModel: patientModel,
      );
      if (newResult == OperationStatus.succeed) {
        await EasyLoading.showSuccess('Data saved successfully.');
      } else {
        await EasyLoading.showError('There is a problem, please try again!');
      }
    }
  } on SocketException catch (_) {
    displaySnackBar(
      context: context,
      text: 'No internet connection found!',
      backgroundColor: Colors.red[300],
    );
  }
}
