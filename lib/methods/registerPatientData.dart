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

      var result = await DatabaseServices.mongoDb().singlePatientData(
        idNumber: patientModel.passportNumber,
      );

      if (result == OperationStatus.failed) {
        OperationStatus newResult = await DatabaseServices.mongoDb().registerPatient(
          patientModel: patientModel,
        );
        if (newResult == OperationStatus.succeed) {
          await EasyLoading.showSuccess('Data saved successfully.');
        } else {
          await EasyLoading.showError('There is a problem, please try again!');
        }
      } else {
        var from = DateTime.parse(result.resultTakenDate);
        var to = DateTime.now();

        final dateDifference = (to.difference(from).inHours / 24).round();
        if (patientModel.fullName != result.fullName ||
            patientModel.gender != result.gender ||
            patientModel.nationality != result.nationality) {
          await EasyLoading.showError(
            'This ID belongs to another patient, Please use another one, OR make sure you put the data correctly!',
            duration: const Duration(seconds: 2),
          );
        } else if (dateDifference < 14) {
          await EasyLoading.showError(
            'This patient already taken the test, Should be more than 14 days to take a test again.',
            duration: const Duration(seconds: 2),
          );
        } else {
          OperationStatus newResult = await DatabaseServices.mongoDb().registerPatient(
            patientModel: patientModel,
          );
          if (newResult == OperationStatus.succeed) {
            await EasyLoading.showSuccess('Data saved successfully.');
          } else {
            await EasyLoading.showError('There is a problem, please try again!');
          }
        }
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
