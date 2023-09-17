import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/android/widgets/commons/app_screen_args.dart';
import 'package:predi_v2/shared/blocs/patient/patient_bloc.dart';

import '../../../../shared/blocs/authentication/auth_bloc.dart';
import '../../../../shared/blocs/authentication/auth_state.dart';
import '../../../../shared/blocs/data/data_bloc.dart';
import '../../../../shared/blocs/data/data_event.dart';
import '../../../../shared/blocs/patient/patient_event.dart';
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
                age: _getAge(state.patient),
                date: DateTime.now(),
                highBP: widget.patientSurvey['high_bp'],
                highChol: widget.patientSurvey['high_chol'],
                genHlth: widget.patientSurvey['gen_hlth'] == 0
                    ? 1
                    : widget.patientSurvey['gen_hlth'],
                physActivity: widget.patientSurvey['phys_activity'],
                physHlth: widget.patientSurvey['phys_hlth'],
                education: widget.patientSurvey['education'] == 0
                    ? 1
                    : widget.patientSurvey['education'],
                fruits: widget.patientSurvey['fruits'],
                veggies: widget.patientSurvey['veggies'],
                smoker: widget.patientSurvey['smoker']);

            //debugPrint('-------> ${widget.patientSurvey}');
            context.read<DataBloc>().add(AddDataRequested(
                patient: state.patient,
                dataType: DataTypeEnum.survey,
                data: patientSurveyModel));
            //debugPrint('-------> Survey criadoooo');
            state.patient.isSurveyCompleted = true;
            context
                .read<PatientBloc>()
                .add(UpdatePatientRequested(patient: state.patient));
            Navigator.pushReplacementNamed(context, '/home_screen',
                arguments: DefaultScreenArguments(patient: state.patient));
          }
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
          style: const TextStyle(fontWeight: FontWeight.bold)),
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
