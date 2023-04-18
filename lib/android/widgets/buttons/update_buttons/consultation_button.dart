import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/shared/models/patients/consultation_model.dart';

import '../../../../shared/blocs/authentication/auth_bloc.dart';
import '../../../../shared/blocs/authentication/auth_state.dart';
import '../../../../shared/blocs/data/data_bloc.dart';
import '../../../../shared/blocs/data/data_event.dart';

import '../../../../shared/models/enums/data_type_enum.dart';

class ConsultationButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final ConsultationModel consultation;

  const ConsultationButton(
      {super.key, required this.formKey, required this.consultation});

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
              context.read<DataBloc>().add(AddDataRequested(
                  patient: state.patient,
                  dataType: DataTypeEnum.consultation,
                  data: consultation));
            }
          }
        },
        /*style: ElevatedButton.styleFrom(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            minimumSize: const Size(double.infinity, 45.0)),*/
        child: const Text(
          "Adicionar consulta",
        ),
      ),
    );
  }
}
