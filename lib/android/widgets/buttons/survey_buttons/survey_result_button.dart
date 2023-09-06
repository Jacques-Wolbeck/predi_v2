import 'package:flutter/material.dart';
import 'package:predi_v2/android/widgets/commons/app_screen_args.dart';
import 'package:predi_v2/shared/controllers/firebase/firebase_db.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';
import 'package:predi_v2/shared/models/patients/survey_model.dart';

import '../../../../shared/services/prediabetes_api_service.dart';
import '../../commons/app_progress_indicator.dart';

class SurveyResultButton extends StatefulWidget {
  final PatientModel patient;
  const SurveyResultButton({super.key, required this.patient});

  @override
  State<SurveyResultButton> createState() => _SurveyResultButtonState();
}

class _SurveyResultButtonState extends State<SurveyResultButton> {
  late final SurveyModel? surveyData;

  @override
  void initState() {
    _getSurveyData();
    super.initState();
  }

  void _getSurveyData() async {
    surveyData = await FirebaseDb.instance.getLastSurvey(widget.patient);
    surveyData!.bmi = widget.patient.bmi!.toInt();
    surveyData!.sex = widget.patient.gender == "Masculino" ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/survey_screen',
            arguments: DefaultScreenArguments(patient: widget.patient));
        /*showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Prediabetes Classifier'),
                content: Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  child: FutureBuilder(
                      future:
                          PrediabetesApiService.instance.predict(surveyData!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data.toString());
                        } else if (snapshot.hasError) {
                          return const Text('Deu erro');
                        } else {
                          return const Center(
                            heightFactor: 25.0,
                            child: AppProgressIndicator(),
                          );
                        }
                      }),
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Sair'))
                ],
              );
            });*/
      },
      style: ElevatedButton.styleFrom(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: const Text('Questionário'),
    );
  }
}


/* future: PrediabetesApiService.instance
                            .predict(patientSurveyModel),*/