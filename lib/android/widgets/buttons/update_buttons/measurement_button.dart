import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../../../../shared/blocs/authentication/auth_bloc.dart';
import '../../../../shared/blocs/authentication/auth_state.dart';
import '../../../../shared/blocs/data/data_bloc.dart';
import '../../../../shared/blocs/data/data_event.dart';
import '../../../../shared/blocs/patient/patient_bloc.dart';
import '../../../../shared/blocs/patient/patient_event.dart';
import '../../../../shared/models/enums/data_type_enum.dart';
import '../../../../shared/models/patients/measurement_model.dart';

class MeasurementButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final PatientModel patient;

  const MeasurementButton(
      {super.key, required this.formKey, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            formKey.currentState!.reset();
            final state = context.read<AuthBloc>().state;
            if (state is Authenticated) {
              context
                  .read<PatientBloc>()
                  .add(UpdatePatientRequested(patient: patient));
              final newMeasure = MeasurementModel(
                date: DateTime.now(),
                weight: patient.weight,
                circumference: patient.circumference,
              );

              context.read<DataBloc>().add(AddDataRequested(
                  patient: patient,
                  dataType: DataTypeEnum.measure,
                  data: newMeasure));
            }
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: const Text(
          "Atualizar",
        ),
      ),
    );
  }
}
