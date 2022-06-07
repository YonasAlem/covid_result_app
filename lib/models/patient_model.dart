import 'dart:convert';

PatientModel patientModelFromJson(String str) {
  return PatientModel.fromJson(json.decode(str));
}

String patientModelToJson(PatientModel data) {
  return json.encode(data.toJson());
}

class PatientModel {
  final String fullName;
  final String passportNumber;
  final String dateOfBirth;
  final String gender;
  final String nationality;
  final String result;
  final String resultTakenDate;

  PatientModel({
    required this.fullName,
    required this.passportNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.nationality,
    required this.result,
    required this.resultTakenDate,
  });

  factory PatientModel.fromJson(json) {
    return PatientModel(
      fullName: json['fullName'],
      passportNumber: json['passportNum'],
      dateOfBirth: json['dbo'],
      gender: json['sex'],
      nationality: json['nationality'],
      result: json['result'],
      resultTakenDate: json['resultDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'passportNum': passportNumber,
      'dbo': dateOfBirth,
      'sex': gender,
      'nationality': nationality,
      'result': result,
      'resultDate': resultTakenDate,
    };
  }
}
