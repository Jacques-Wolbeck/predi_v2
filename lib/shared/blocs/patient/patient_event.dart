import 'package:equatable/equatable.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

abstract class PatientEvent extends Equatable {
  const PatientEvent();

  @override
  List<Object?> get props => [];
}

class UpdatePatientRequested extends PatientEvent {
  final PatientModel patient;

  const UpdatePatientRequested({required this.patient});
  @override
  List<Object?> get props => [patient];
}
