import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/shared/blocs/data/data_event.dart';
import 'package:predi_v2/shared/models/enums/data_type_enum.dart';
import 'package:predi_v2/shared/models/patients/rate_model.dart';

import '../../../../shared/blocs/data/data_bloc.dart';
import '../../../../shared/blocs/patient/patient_bloc.dart';
import '../../../../shared/blocs/patient/patient_event.dart';
import '../../../../shared/models/patients/patient_model.dart';

class RateButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final PatientModel patient;

  const RateButton({super.key, required this.formKey, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            var updatedPatient = patient.copyWith(cholesterol: 0.00);
            context
                .read<PatientBloc>()
                .add(UpdatePatientRequested(patient: updatedPatient));
            final newRate = RateModel(
                date: DateTime.now(),
                cholesterol: updatedPatient.cholesterol,
                fastingGlucose: updatedPatient.fastingGlucose,
                glucose75g: updatedPatient.glucose75g,
                glycatedHemoglobin: updatedPatient.glycatedHemoglobin);

            context.read<DataBloc>().add(AddDataRequested(
                patient: patient, dataType: DataTypeEnum.rate, data: newRate));
          }
        },
        /*style: ElevatedButton.styleFrom(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            minimumSize: const Size(double.infinity, 45.0)),*/
        child: const Text(
          "Atualizar",
        ),
      ),
    );
  }
}
