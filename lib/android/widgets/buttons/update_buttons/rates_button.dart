import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/shared/blocs/authentication/auth_state.dart';
import 'package:predi_v2/shared/blocs/data/data_event.dart';
import 'package:predi_v2/shared/models/enums/data_type_enum.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';
import 'package:predi_v2/shared/models/patients/rate_model.dart';

import '../../../../shared/blocs/authentication/auth_bloc.dart';
import '../../../../shared/blocs/data/data_bloc.dart';
import '../../../../shared/blocs/patient/patient_bloc.dart';
import '../../../../shared/blocs/patient/patient_event.dart';

class RatesButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final PatientModel patient;

  const RatesButton({super.key, required this.formKey, required this.patient});

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
              //var updatedPatient = patient.copyWith(cholesterol: 0.00);
              context
                  .read<PatientBloc>()
                  .add(UpdatePatientRequested(patient: patient));
              final newRate = RateModel(
                  date: DateTime.now(),
                  cholesterol: patient.cholesterol,
                  fastingGlucose: patient.fastingGlucose,
                  glucose75g: patient.glucose75g,
                  glycatedHemoglobin: patient.glycatedHemoglobin);

              context.read<DataBloc>().add(AddDataRequested(
                  patient: patient,
                  dataType: DataTypeEnum.rate,
                  data: newRate));
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
