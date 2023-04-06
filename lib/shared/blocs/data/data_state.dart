import 'package:equatable/equatable.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object?> get props => [];
}

class InitialDataState extends DataState {}

class LoadingData extends DataState {}

class DataLoaded extends DataState {
  final List<dynamic> dataList;

  const DataLoaded({this.dataList = const []});

  @override
  List<Object?> get props => [dataList];
}

class Concluded extends DataState {}

class DataError extends DataState {
  final String error;

  const DataError(this.error);
  @override
  List<Object?> get props => [error];
}
