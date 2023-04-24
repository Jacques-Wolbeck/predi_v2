import 'package:flutter/material.dart';
import 'package:predi_v2/shared/models/enums/patient_status_enum.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../alerts/report_information_alert.dart';

class AppReportInformation extends StatelessWidget {
  final PatientModel patient;
  const AppReportInformation({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Gerar Relatório',
      icon: Icon(
        Icons.favorite_border,
        shadows: <Shadow>[
          Shadow(
              color: Theme.of(context).colorScheme.shadow,
              blurRadius: 2.0,
              offset: const Offset(1.0, 1.0))
        ],
      ),
      iconSize: MediaQuery.of(context).size.height * .25,
      color: Theme.of(context).colorScheme.secondary,
      onPressed: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              PatientStatusEnum patientEnum = _statusCalculation();
              return ReportInformationAlert(
                title: patientEnum.status,
                content: patientEnum.content,
              );
            });
      },
    );
  }

  PatientStatusEnum _statusCalculation() {
    if (patient.fastingGlucose != null &&
        patient.glucose75g != null &&
        patient.glycatedHemoglobin != null) {
      if (patient.fastingGlucose! < 100.0) {
        return PatientStatusEnum.goodFastingGlucose;
      } else if (patient.fastingGlucose! >= 100.0 &&
          patient.fastingGlucose! <= 125.0) {
        if (patient.glucose75g! <= 199.0) {
          if (patient.glycatedHemoglobin! < 5.7) {
            return PatientStatusEnum.alteredFastingGlucose;
          } else if (patient.glycatedHemoglobin! >= 5.7 &&
              patient.glycatedHemoglobin! <= 6.4) {
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
