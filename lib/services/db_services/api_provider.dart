import 'dart:convert' show json;

import 'package:covid_result_app/models/patient_model.dart';
import 'package:covid_result_app/services/db_services/db_provider.dart';
import 'package:http/http.dart' as http;

import '../../enums/operation_status.dart';

class ApiProvider implements DatabaseProvider {
  final apiUri = 'https://covid-result-tester.herokuapp.com/api/users/';
  @override
  Future<OperationStatus> registerPatient({required PatientModel patientModel}) async {
    final Uri uri = Uri.parse(apiUri);
    http.Response response = await http.post(uri, body: patientModel.toJson());

    if (response.statusCode == 200) {
      return OperationStatus.succeed;
    } else {
      return OperationStatus.failed;
    }
  }

  @override
  Future<List<PatientModel>> viewAllPatient() async {
    final response = await http.get(Uri.parse(apiUri));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body.map<PatientModel>(PatientModel.fromJson).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Future singlePatientData({required String idNumber}) async {
    final response = await http.get(Uri.parse('$apiUri$idNumber'));

    if (response.statusCode == 200) {
      final patient = PatientModel.fromJson(json.decode(response.body));
      return patient;
    } else {
      return OperationStatus.failed;
    }
  }
}
