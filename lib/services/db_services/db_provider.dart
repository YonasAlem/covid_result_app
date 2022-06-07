import 'package:covid_result_app/models/patient_model.dart';

import '../../enums/operation_status.dart';

abstract class DatabaseProvider {
  Future<OperationStatus> registerPatient({required PatientModel patientModel});
}
