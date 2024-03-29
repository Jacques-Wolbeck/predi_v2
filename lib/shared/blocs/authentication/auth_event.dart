import 'package:equatable/equatable.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class RegisterNewPatientRequested extends AuthEvent {
  final String email;
  final String password;
  final PatientModel patient;

  const RegisterNewPatientRequested(
      {required this.email, required this.password, required this.patient});
  @override
  List<Object?> get props => [email, password, patient];
}

class EmailPasswordSignInRequested extends AuthEvent {
  final String email;
  final String password;

  const EmailPasswordSignInRequested(
      {required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class GoogleSignInRequested extends AuthEvent {}

class ResetPasswordRequested extends AuthEvent {
  final String email;

  const ResetPasswordRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

class CheckLoginRequested extends AuthEvent {}

class SignOutRequested extends AuthEvent {}
