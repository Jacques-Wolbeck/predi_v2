import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/blocs/authentication/auth_bloc.dart';
import '../../../../shared/blocs/authentication/auth_state.dart';
import '../../../../shared/blocs/data/data_bloc.dart';
import '../../../../shared/blocs/data/data_event.dart';
import '../../../../shared/models/enums/data_type_enum.dart';
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
          final state = context.read<AuthBloc>().state;
          if (state is Authenticated) {
            final patientSurveyModel = SurveyModel(
              //bmi: state.patient.bmi,
              age: _getAge(state.patient),
              date: DateTime.now(),
              highBP: widget.patientSurvey['highBp'],
              highChol: widget.patientSurvey['highChol'],
              heartDiseaseorAttack:
                  widget.patientSurvey['heartDiseaseorAttack'],
              genHlth: widget.patientSurvey['genHlth'] == 0
                  ? 1
                  : widget.patientSurvey['genHlth'],
              diffWalk: widget.patientSurvey['diffWalk'],
              physActivity: widget.patientSurvey['physActivity'],
              physHlth: widget.patientSurvey['physHlth'],
              education: widget.patientSurvey['education'] == 0
                  ? 1
                  : widget.patientSurvey['education'],
            );

            debugPrint('-------> ${widget.patientSurvey}');
            context.read<DataBloc>().add(AddDataRequested(
                patient: state.patient,
                dataType: DataTypeEnum.survey,
                data: patientSurveyModel));
            debugPrint('-------> Survey criadoooo');
            Navigator.pop(context);
            /*showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Prediabetes Classifier'),
                    content: Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(16.0),
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
                });*/
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
        widget.currentIndex == 2 ? "Finalizar questionário" : "Próximo",
      ),
    );
  }

  int _getAge(PatientModel patient) {
    var age = DateTime.now().year - patient.birthDate!.year;
    debugPrint('-------> age: ${patient.birthDate!.year.toString()}');
    debugPrint('-------> age: $age');
    if (age <= 24) {
      return 1;
    } else if (age >= 25 && age <= 29) {
      return 2;
    } else if (age >= 30 && age <= 34) {
      return 3;
    } else if (age >= 35 && age <= 39) {
      return 4;
    } else if (age >= 40 && age <= 44) {
      return 5;
    } else if (age >= 45 && age <= 49) {
      return 6;
    } else if (age >= 50 && age <= 54) {
      return 7;
    } else if (age >= 55 && age <= 59) {
      return 8;
    } else if (age >= 60 && age <= 64) {
      return 9;
    } else if (age >= 65 && age <= 69) {
      return 10;
    } else if (age >= 70 && age <= 74) {
      return 11;
    } else if (age >= 75 && age <= 79) {
      return 12;
    } else {
      return 13;
    }
  }
}
