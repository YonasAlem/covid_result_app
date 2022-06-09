import 'package:covid_result_app/methods/my_app_bar.dart';
import 'package:covid_result_app/methods/warning_dialog.dart';
import 'package:covid_result_app/services/db_services/database_services.dart';
import 'package:covid_result_app/views/patient_update_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/patient_model.dart';

class PatientListView extends StatefulWidget {
  static const String routeName = '/viewPatient/';
  const PatientListView({Key? key}) : super(key: key);

  @override
  State<PatientListView> createState() => _PatientListViewState();
}

class _PatientListViewState extends State<PatientListView> {
  late Future<List<PatientModel>> patientListModel;
  @override
  void initState() {
    patientListModel = DatabaseServices.mongoDb().viewAllPatient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        backgroundColor: const Color(0xFFdb7634),
        title: "Patient's List",
      ),
      body: FutureBuilder(
        future: patientListModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<PatientModel> patientList = snapshot.data as List<PatientModel>;

            return patientList.isEmpty
                ? _buildEmptyPatientList()
                : _buildPatientListView(patientList: patientList);
          } else if (snapshot.hasError) {}
          return Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.black.withOpacity(0.1),
            child: Center(
              child: Container(
                width: 200,
                height: 120,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SpinKitCircle(
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Please wait while loading!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Column _buildEmptyPatientList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/empty.png',
          height: 200,
        ),
        const Text(
          'There is no data!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  _buildPatientListView({required List<PatientModel> patientList}) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: patientList.length,
      itemBuilder: (context, index) {
        final PatientModel patient = patientList[index];

        return Column(
          children: [
            ListTile(
              onTap: () => singleListItem(patient: patient),
              horizontalTitleGap: 15,
              leading: Container(
                margin: const EdgeInsets.all(5),
                child: Image.asset(
                  patient.gender == 'Male'
                      ? 'assets/images/male.png'
                      : 'assets/images/female.png',
                  height: 35,
                ),
              ),
              title: Text(
                patient.fullName.toUpperCase(),
                style: const TextStyle(letterSpacing: 1),
              ),
              subtitle: Row(
                children: [
                  Text(
                    'Birthdate: ',
                    style: TextStyle(color: Colors.grey[300], fontSize: 12),
                  ),
                  Text(
                    patient.dateOfBirth,
                    style: const TextStyle(letterSpacing: 1, color: Colors.grey),
                  ),
                ],
              ),
              trailing: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFdb7634),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  onPressed: () async {
                    final shouldUpdate = await warningDialog(
                      context: context,
                      boxTitle: "Update",
                      boxDescription:
                          "This will update the data from the server, Are you sure?",
                      cancleText: "Cancel",
                      okText: "Update",
                    );
                    if (shouldUpdate && mounted) {
                      Navigator.of(context).pushNamed(
                        PatientUpdateView.routeName,
                        arguments: patient,
                      );
                    }
                  },
                  constraints: const BoxConstraints(),
                  icon: Image.asset(
                    'assets/images/edit.png',
                    height: 35,
                  ),
                ),
              ),
            ),
            Divider(
              height: 0,
              thickness: 1,
              indent: 75,
              color: Colors.grey[200],
            ),
          ],
        );
      },
    );
  }

  singleListItem({required PatientModel patient}) {
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
}

class TypeAndValueWidget extends StatelessWidget {
  const TypeAndValueWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),
          Container(
            height: 45,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Center(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  letterSpacing: 1,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
