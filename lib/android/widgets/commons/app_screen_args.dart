import 'package:predi_v2/shared/models/patients/survey_model.dart';

import '../../../shared/models/patients/patient_model.dart';

class DefaultScreenArguments {
  final PatientModel patient;

  const DefaultScreenArguments({required this.patient});
}

class ReportDetailScreenArguments {
  final PatientModel patient;
  final SurveyModel survey;
  const ReportDetailScreenArguments(
      {required this.patient, required this.survey});
}
