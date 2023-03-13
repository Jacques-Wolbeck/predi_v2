import 'package:equatable/equatable.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class Loading extends AuthState {}

class Authenticated extends AuthState {
  final PatientModel patient;
  const Authenticated({required this.patient});

  @override
  List<Object?> get props => [patient];
}

class UnAuthenticated extends AuthState {}

class AuthError extends AuthState {
  final String error;

  const AuthError(this.error);
  @override
  List<Object?> get props => [error];
}
