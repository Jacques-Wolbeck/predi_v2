import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/shared/blocs/authentication/auth_bloc.dart';
import 'package:predi_v2/shared/blocs/authentication/auth_event.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

class HomeScreen extends StatelessWidget {
  final PatientModel patient;
  const HomeScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(patient.name!),
            Text(patient.gender!),
            Text(patient.bmi!.toString()),
            Text(patient.birthDate!.toString()),
            Text(patient.height!.toString()),
            ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(SignOutRequested());
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login_screen', (route) => false);
                },
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
