import 'package:covid_result_app/models/patient_model.dart';
import 'package:covid_result_app/services/db_services/db_provider.dart';
import 'package:http/http.dart' as http;

import '../../enums/operation_status.dart';

class ApiProvider implements DatabaseProvider {
  @override
  Future<OperationStatus> registerPatient({required PatientModel patientModel}) async {
    final Uri uri = Uri.parse('https://covid-result-tester.herokuapp.com/api/users/');
    http.Response response = await http.post(
      uri,
      body: patientModel.toJson(),
    );

    if (response.statusCode == 200) {
      return OperationStatus.succeed;
    } else {
      return OperationStatus.failed;
    }
  }
}
