import 'package:flutter/material.dart';

import '../models/patient_model.dart';
import '../views/patient_list_view.dart';

singleListItem(BuildContext context, {required PatientModel patient}) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFdb7634),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  patient.gender == 'Male'
                      ? 'assets/images/male.png'
                      : 'assets/images/female.png',
                  height: 45,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                Text(
                  patient.fullName.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'ID: @${patient.passportNumber}',
                  style: const TextStyle(
                    fontSize: 15,
                    letterSpacing: 1,
                    color: Colors.white54,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                Row(
                  children: [
                    TypeAndValueWidget(title: 'Result', value: patient.result),
                    const SizedBox(width: 20),
                    TypeAndValueWidget(
                      title: 'Result taken date',
                      value: patient.resultTakenDate.split('T')[0],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    TypeAndValueWidget(title: 'Gender', value: patient.gender),
                    const SizedBox(width: 20),
                    TypeAndValueWidget(title: 'Date of birth', value: patient.dateOfBirth)
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
