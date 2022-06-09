import 'package:covid_result_app/models/patient_model.dart';
import 'package:covid_result_app/services/db_services/api_provider.dart';
import 'package:covid_result_app/services/db_services/db_provider.dart';

import '../../enums/operation_status.dart';

class DatabaseServices implements DatabaseProvider {
  final DatabaseProvider dbProvider;

  DatabaseServices(this.dbProvider);
  factory DatabaseServices.mongoDb() => DatabaseServices(ApiProvider());
  @override
  Future<OperationStatus> registerPatient({required PatientModel patientModel}) {
    return dbProvider.registerPatient(patientModel: patientModel);
  }

  @override
  Future<List<PatientModel>> viewAllPatient() {
    return dbProvider.viewAllPatient();
  }

  @override
  Future singlePatientData({required String idNumber}) {
    return dbProvider.singlePatientData(idNumber: idNumber);
  }
}
