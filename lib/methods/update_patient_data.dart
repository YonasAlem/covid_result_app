import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../enums/operation_status.dart';
import '../models/patient_model.dart';
import '../services/db_services/database_services.dart';
import 'display_snackbar.dart';

Future updatePatientData(context, {required PatientModel patientModel}) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      await EasyLoading.show(status: 'Updating patient data');

      OperationStatus newResult = await DatabaseServices.mongoDb().updatePatient(
        patientModel: patientModel,
      );
      if (newResult == OperationStatus.succeed) {
        await EasyLoading.showSuccess('Data updated successfully.');
        return true;
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
