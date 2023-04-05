import 'package:equatable/equatable.dart';

abstract class PatientState extends Equatable {
  const PatientState();

  @override
  List<Object?> get props => [];
}

class InitialState extends PatientState {}

class Loading extends PatientState {}

class Updated extends PatientState {
  final String message;

  const Updated(this.message);
  @override
  List<Object?> get props => [message];
}

class PatientError extends PatientState {
  final String error;

  const PatientError(this.error);
  @override
  List<Object?> get props => [error];
}
