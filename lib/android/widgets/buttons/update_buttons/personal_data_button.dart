import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/android/widgets/commons/app_screen_args.dart';

import '../../../../shared/blocs/authentication/auth_bloc.dart';
import '../../../../shared/blocs/authentication/auth_state.dart';
import '../../../../shared/blocs/patient/patient_bloc.dart';
import '../../../../shared/blocs/patient/patient_event.dart';

class PersonalDataButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const PersonalDataButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            formKey.currentState!.reset();
            final state = context.read<AuthBloc>().state;
            if (state is Authenticated) {
              state.patient.gender ??= 'Masculino';
              if (state.patient.height! > 3.5) {
                state.patient.height = state.patient.height! / 100;
              }
              context
                  .read<PatientBloc>()
                  .add(UpdatePatientRequested(patient: state.patient));

              if (state.patient.isSurveyCompleted == null ||
                  !state.patient.isSurveyCompleted!) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/survey_screen', (route) => false,
                    arguments: DefaultScreenArguments(patient: state.patient));
              } else {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home_screen', (route) => false,
                    arguments: DefaultScreenArguments(patient: state.patient));
              }
            }
          }
        },
        style: ElevatedButton.styleFrom(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            minimumSize: const Size(double.infinity, 45.0)),
        child: const Text(
          "Atualizar",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
