import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/android/widgets/commons/app_progress_indicator.dart';
import 'package:predi_v2/shared/services/prediabetes_api_service.dart';

import '../../../../shared/blocs/authentication/auth_bloc.dart';
import '../../../../shared/blocs/authentication/auth_state.dart';
import '../../../../shared/models/patients/patient_model.dart';
import '../../../../shared/models/patients/survey_model.dart';

class SurveyFowardButton extends StatefulWidget {
  final PageController pageController;
  final Map<String, int> patientSurvey;
  final int currentIndex;
  const SurveyFowardButton(
      {super.key,
      required this.pageController,
      required this.patientSurvey,
      required this.currentIndex});

  @override
  State<SurveyFowardButton> createState() => _SurveyFowardButtonState();
}

class _SurveyFowardButtonState extends State<SurveyFowardButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (widget.currentIndex == 0) {
          setState(() {
            widget.pageController.jumpToPage(1);
          });
        } else if (widget.currentIndex == 1) {
          setState(() {
            widget.pageController.jumpToPage(2);
          });
        } else if (widget.currentIndex == 2) {
          setState(() {
            widget.pageController.jumpToPage(3);
          });
        } else if (widget.currentIndex == 3) {
          final state = context.read<AuthBloc>().state;
          if (state is Authenticated) {
            final patientSurveyModel = SurveyModel(
              /*bmi: state.patient.bmi,
                age: _getAge(state.patient),*/
              bmi: 26,
              age: 27,
              highBP: widget.patientSurvey['highBp']!.toInt(),
              highChol: widget.patientSurvey['highChol'],
              cholCheck: widget.patientSurvey['cholCheck'],
              heartDiseaseorAttack:
                  widget.patientSurvey['heartDiseaseorAttack'],
              genHlth: widget.patientSurvey['genHlth'],
              diffWalk: widget.patientSurvey['diffWalk'],
              physActivity: widget.patientSurvey['physActivity'],
              physHlth: widget.patientSurvey['physHlth'],
              mentHlth: widget.patientSurvey['mentHlth'],
              education: 3,
              income: 1,
            );

            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Prediabetes Classifier'),
                    content: Container(
                      margin: EdgeInsets.all(16.0),
                      padding: EdgeInsets.all(16.0),
                      child: FutureBuilder(
                          future: PrediabetesApiService.instance
                              .predict(patientSurveyModel),
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
                });
          }
          /*var x = [
            1.0,
            0.0,
            1.0,
            32.0,
            5.0,
            0.0,
            5.0,
            0.0,
            6.0,
            0.0,
            0.0,
            3.0,
            1.0,
          ];*/
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(328, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        widget.currentIndex == 3 ? "Finalizar questionário" : "Próximo",
      ),
    );
  }

  double _getAge(PatientModel patient) {
    var age = DateTime.now().year - patient.birthDate!.year;
    debugPrint('-------> age: ${patient.birthDate!.year.toString()}');
    debugPrint('-------> age: $age');
    if (age <= 24) {
      return 1.0;
    } else if (age >= 25 && age <= 29) {
      return 2.0;
    } else if (age >= 30 && age <= 34) {
      return 3.0;
    } else if (age >= 35 && age <= 39) {
      return 4.0;
    } else if (age >= 40 && age <= 44) {
      return 5.0;
    } else if (age >= 45 && age <= 49) {
      return 6.0;
    } else if (age >= 50 && age <= 54) {
      return 7.0;
    } else if (age >= 55 && age <= 59) {
      return 8.0;
    } else if (age >= 60 && age <= 64) {
      return 9.0;
    } else if (age >= 65 && age <= 69) {
      return 10.0;
    } else if (age >= 70 && age <= 74) {
      return 11.0;
    } else if (age >= 75 && age <= 79) {
      return 12.0;
    } else {
      return 13.0;
    }
  }
}
