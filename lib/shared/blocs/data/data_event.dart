import 'package:equatable/equatable.dart';
import 'package:predi_v2/shared/models/enums/data_type_enum.dart';

import '../../models/patients/patient_model.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object?> get props => [];
}

class LoadDataRequested extends DataEvent {
  final PatientModel patient;
  final DataTypeEnum dataType;

  const LoadDataRequested({required this.patient, required this.dataType});

  @override
  List<Object?> get props => [patient, patient];
}

class AddDataRequested extends DataEvent {
  final PatientModel patient;
  final DataTypeEnum dataType;
  final dynamic data;

  const AddDataRequested(
      {required this.patient, required this.dataType, required this.data});

  @override
  List<Object?> get props => [patient, dataType, data];
}

class UpdateDataRequested extends DataEvent {
  final PatientModel patient;
  final DataTypeEnum dataType;
  final dynamic data;

  const UpdateDataRequested(
      {required this.patient, required this.dataType, required this.data});

  @override
  List<Object?> get props => [patient, dataType, data];
}

class DeleteDataRequested extends DataEvent {
  final PatientModel patient;
  final DataTypeEnum dataType;
  final List<dynamic> deleteList;

  const DeleteDataRequested(
      {required this.patient,
      required this.dataType,
      required this.deleteList});

  @override
  List<Object?> get props => [patient, dataType, deleteList];
}
