import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/firebase/firebase_db.dart';
import 'data_event.dart';
import 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final FirebaseDb _dbInstance = FirebaseDb.instance;

  DataBloc() : super(InitialDataState()) {
    // todos events
    on<AddDataRequested>(_onAddDataRequested);
    on<UpdateDataRequested>(_onUpdateDataRequested);
    on<DeleteDataRequested>(_onDeleteDataRequested);
    on<LoadDataRequested>(_onLoadDataRequested);
  }

  void _onAddDataRequested(
      AddDataRequested event, Emitter<DataState> emit) async {
    emit(LoadingData());
    try {
      await _dbInstance.create(event.patient, event.dataType, event.data);
      emit(Concluded(
          feedbackMessage:
              '${event.dataType.primaryTitle} adicionadas com sucesso.'));
    } catch (error) {
      emit(DataError(error.toString()));
      emit(InitialDataState());
    }
  }

  void _onUpdateDataRequested(
      UpdateDataRequested event, Emitter<DataState> emit) async {
    emit(LoadingData());
    try {
      await _dbInstance.update(event.patient, event.dataType, event.data);
      emit(Concluded(
          feedbackMessage:
              '${event.dataType.primaryTitle} editadas com sucesso.'));
    } catch (error) {
      emit(DataError(error.toString()));
      emit(InitialDataState());
    }
  }

  void _onDeleteDataRequested(
      DeleteDataRequested event, Emitter<DataState> emit) async {
    emit(LoadingData());
    try {
      await _dbInstance.delete(event.patient, event.dataType, event.deleteList);
      emit(Concluded(
          feedbackMessage:
              '${event.dataType.primaryTitle} deletadas com sucesso.'));
    } catch (error) {
      emit(DataError(error.toString()));
      emit(InitialDataState());
    }
  }

  void _onLoadDataRequested(
      LoadDataRequested event, Emitter<DataState> emit) async {
    emit(LoadingData());
    try {
      await emit.forEach(_dbInstance.getAll(event.patient, event.dataType),
          onData: (dataList) {
        return DataLoaded(dataList: dataList as List<dynamic>);
      });
    } catch (error) {
      emit(DataError(error.toString()));
      emit(InitialDataState());
    }
  }
}
