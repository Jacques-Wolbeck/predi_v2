import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/android/widgets/commons/app_screen_args.dart';

import '../../../../shared/blocs/patient/patient_bloc.dart';
import '../../../../shared/blocs/patient/patient_event.dart';
import '../../../../shared/models/patients/patient_model.dart';

class PersonalDataButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final PatientModel patient;

  const PersonalDataButton(
      {super.key, required this.formKey, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            patient.gender ??= 'Masculino';
            context
                .read<PatientBloc>()
                .add(UpdatePatientRequested(patient: patient));
            Navigator.pushNamedAndRemoveUntil(
                context, '/home_screen', (route) => false,
                arguments: DefaultScreenArguments(patient: patient));
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
        ),
      ),
    );
  }
}
