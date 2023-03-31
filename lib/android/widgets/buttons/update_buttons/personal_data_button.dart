import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/android/widgets/commons/app_screen_args.dart';

import '../../../../shared/blocs/patient/patient_bloc.dart';
import '../../../../shared/blocs/patient/patient_event.dart';
import '../../../../shared/blocs/patient/patient_state.dart';
import '../../../../shared/models/patients/patient_model.dart';
import '../../commons/app_snack_bar.dart';

class PersonalDataButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final PatientModel patient;

  // TODO os sncaks bars do bloc  listner noa estoau funcionando
  const PersonalDataButton(
      {super.key, required this.formKey, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocListener<PatientBloc, PatientState>(
        listener: (context, state) {
          if (state is Updated) {
            ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(message: state.message).snack(context));
          }
          if (state is PatientError) {
            ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(message: state.error, isError: true)
                    .snack(context));
          }
        },
        child: ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
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
      ),
    );
  }
}
