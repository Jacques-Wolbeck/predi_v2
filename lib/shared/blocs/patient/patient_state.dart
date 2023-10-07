import 'package:equatable/equatable.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

abstract class PatientState extends Equatable {
  const PatientState();

  @override
  List<Object?> get props => [];
}

class InitialState extends PatientState {}

class Loading extends PatientState {}

class Updated extends PatientState {
  final String message;
  final PatientModel patient;

  const Updated(this.message, this.patient);
  @override
  List<Object?> get props => [message, patient];
}

class PatientError extends PatientState {
  final String error;

  const PatientError(this.error);
  @override
  List<Object?> get props => [error];
}
