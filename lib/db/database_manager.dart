import 'package:http/http.dart' as http;

import '../models/patient_model.dart';

enum OperationStatus { succeed, failed }

class DatabaseManager {
  static Future<OperationStatus> addNewPatient({required PatientModel patient}) async {
    final Uri uri = Uri.parse('https://covid-result-tester.herokuapp.com/api/users/');
    print(patient.toJson());
    http.Response response = await http.post(
      uri,
      body: patient.toJson(),
    );

    if (response.statusCode == 200) {
      return OperationStatus.succeed;
    } else {
      return OperationStatus.failed;
    }
  }
}
