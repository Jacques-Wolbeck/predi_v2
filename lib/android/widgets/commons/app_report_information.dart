import 'package:flutter/material.dart';
import 'package:predi_v2/shared/controllers/firebase/firebase_db.dart';
import 'package:predi_v2/shared/models/enums/patient_status_enum.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';
import 'package:predi_v2/shared/models/patients/survey_model.dart';

import '../alerts/report_information_alert.dart';

class AppReportInformation extends StatefulWidget {
  final PatientModel patient;
  const AppReportInformation({super.key, required this.patient});

  @override
  State<AppReportInformation> createState() => _AppReportInformationState();
}

class _AppReportInformationState extends State<AppReportInformation> {
  late final SurveyModel? surveyData;

  @override
  void initState() {
    _getSurveyData();
    super.initState();
  }

  void _getSurveyData() async {
    surveyData = await FirebaseDb.instance.getLastSurvey(widget.patient);
    if (widget.patient.bmi == null) {
      surveyData!.bmi = 0;
    } else {
      surveyData!.bmi = widget.patient.bmi!.toInt();
    }

    surveyData!.sex = widget.patient.gender == "Masculino" ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Gerar Relatório',
      iconSize: MediaQuery.of(context).size.height * .25,
      color: Theme.of(context).colorScheme.primary,
      icon: Icon(
        Icons.favorite_border,
        shadows: <Shadow>[
          Shadow(
              color: Theme.of(context).colorScheme.shadow,
              blurRadius: 1.5,
              offset: const Offset(2.0, -1.0))
        ],
      ),
      onPressed: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              PatientStatusEnum patientEnum = _statusCalculation();
              return ReportInformationAlert(
                patient: widget.patient,
                patientEnum: patientEnum,
                surveyData: surveyData,
              );
            });
      },
    );
  }

  PatientStatusEnum _statusCalculation() {
    if (widget.patient.fastingGlucose != null &&
        widget.patient.glucose75g != null &&
        widget.patient.glycatedHemoglobin != null &&
        widget.patient.weight != null) {
      if (widget.patient.fastingGlucose! < 100.0) {
        return PatientStatusEnum.goodFastingGlucose;
      } else if (widget.patient.fastingGlucose! >= 100.0 &&
          widget.patient.fastingGlucose! <= 125.0) {
        if (widget.patient.glucose75g! <= 199.0) {
          if (widget.patient.glycatedHemoglobin! < 5.7) {
            return PatientStatusEnum.alteredFastingGlucose;
          } else if (widget.patient.glycatedHemoglobin! >= 5.7 &&
              widget.patient.glycatedHemoglobin! <= 6.4) {
            return PatientStatusEnum.preDiabetes;
          }
          return PatientStatusEnum.diabetes;
        }
        return PatientStatusEnum.highGlucose75g;
      }
      return PatientStatusEnum.highFastingGlucose;
    }
    return PatientStatusEnum.noData;
  }
}
