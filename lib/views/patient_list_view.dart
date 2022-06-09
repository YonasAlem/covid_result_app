import 'package:covid_result_app/methods/my_app_bar.dart';
import 'package:covid_result_app/services/db_services/database_services.dart';
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
      appBar: appBar(
        backgroundColor: const Color(0xFFdb7634),
        title: "Patient's List",
      ),
      body: FutureBuilder(
        future: patientListModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<PatientModel> patientList = snapshot.data as List<PatientModel>;
            return _buildPatientListView(patientList: patientList);
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

  _buildPatientListView({required List<PatientModel> patientList}) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: patientList.length,
      itemBuilder: (context, index) {
        final PatientModel patient = patientList[index];
        return ListTile(
          title: Text(patient.fullName),
          subtitle: Text(patient.dateOfBirth),
        );
      },
    );
  }
}
