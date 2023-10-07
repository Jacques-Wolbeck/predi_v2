import 'package:flutter/material.dart';
import 'package:predi_v2/android/widgets/commons/app_progress_indicator.dart';
import 'package:predi_v2/android/widgets/commons/app_screen_args.dart';
import 'package:predi_v2/shared/models/enums/patient_status_enum.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';
import 'package:predi_v2/shared/models/patients/survey_model.dart';
import 'package:predi_v2/shared/services/prediabetes_api_service.dart';

class ReportInformationAlert extends StatefulWidget {
  final PatientModel patient;
  final PatientStatusEnum patientEnum;
  final SurveyModel? surveyData;

  const ReportInformationAlert(
      {super.key,
      required this.patient,
      required this.patientEnum,
      required this.surveyData});

  @override
  State<ReportInformationAlert> createState() => _ReportInformationAlertState();
}

class _ReportInformationAlertState extends State<ReportInformationAlert> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PrediabetesApiService.instance.predict(widget.surveyData!),
        builder: (context, snapshot) {
          if (widget.patientEnum == PatientStatusEnum.noData) {
            return _alertDialog(
                widget.patientEnum.status,
                Text(
                  widget.patientEnum.content,
                  //snapshot.data!.prediction.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(),
                ),
                0);
          } else if (snapshot.hasData) {
            return _alertDialog(
                widget.patientEnum.status,
                Text(
                  widget.patientEnum.content,
                  //snapshot.data!.prediction.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(),
                ),
                snapshot.data!.prediction);
          } else if (snapshot.hasError) {
            return _alertDialog(
                'Erro inesperado',
                const Center(
                  child: Icon(Icons.error),
                ),
                0);
          }
          return _alertDialog(
              'Gerando...', const Center(child: AppProgressIndicator()), 0);
        });
  }

  Widget _alertDialog(String title, Widget content, int predictionResult) {
    return AlertDialog(
      iconPadding: EdgeInsets.zero,
      icon: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Relatório',
              style: Theme.of(context).textTheme.headlineSmall!.merge(
                    TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
            ),
            const SizedBox(height: 8.0),
            Image.asset(
              'assets/images/icons/report_icon.png',
              height: 45.0,
              width: 45.0,
              color: Theme.of(context).colorScheme.onPrimary,
            )
          ],
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(),
        ),
      ),
      content: content,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      actions: [
        _detailsButtonCondition(predictionResult)
            ? ElevatedButton(
                onPressed: () => Navigator.pushNamed(
                    context, '/report_detail_screen',
                    arguments: ReportDetailScreenArguments(
                        patient: widget.patient, survey: widget.surveyData!)),
                style: ElevatedButton.styleFrom(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.info_outline),
                    SizedBox(width: 4.0),
                    Text('Detalhes',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            : const SizedBox.shrink(),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.keyboard_return_outlined),
              SizedBox(width: 4.0),
              Text('Voltar', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  bool _detailsButtonCondition(int predictionResult) {
    return (widget.patientEnum == PatientStatusEnum.preDiabetes ||
            (widget.patientEnum == PatientStatusEnum.goodFastingGlucose &&
                predictionResult == 1))
        ? true
        : false;
  }
}
