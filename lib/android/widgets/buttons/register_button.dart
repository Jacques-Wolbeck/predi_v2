import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/shared/blocs/authentication/auth_event.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';
import 'package:intl/intl.dart';

import '../../../shared/blocs/authentication/auth_bloc.dart';

class RegisterButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, String> loginInfo;
  final PatientModel patient;

  const RegisterButton(
      {super.key,
      required this.formKey,
      required this.loginInfo,
      required this.patient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            //debugPrint(
            //'${loginInfo['email']} ---> ${loginInfo['password']} --> ${patient.name} --> ${patient.gender} --> ${DateFormat('dd-MM-yyyy').format(patient.birthDate!)}');
            context.read<AuthBloc>().add(RegisterNewPatientRequested(
                email: loginInfo['email']!,
                password: loginInfo['password']!,
                patient: patient));
            Navigator.pop(context);
          }
        },
        style: ElevatedButton.styleFrom(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            minimumSize: const Size(double.infinity, 45.0)),
        child: const Text(
          "Cadastrar",
        ),
      ),
    );
  }
}
