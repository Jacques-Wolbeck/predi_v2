import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/shared/blocs/patient/patient_event.dart';
import 'package:predi_v2/shared/blocs/patient/patient_state.dart';

import '../../controllers/patient_controller.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final patientController = PatientController.instance;

  PatientBloc() : super(InitialState()) {
    on<UpdatePatientRequested>(_onUpdatePatientRequested);
  }

  void _onUpdatePatientRequested(
      UpdatePatientRequested event, Emitter<PatientState> emit) async {
    emit(Loading());
    try {
      await patientController.updatePatient(event.patient);
      emit(const Updated('Atualização de dados concluida.'));
    } catch (error) {
      emit(PatientError(error.toString()));
    }
  }
}
