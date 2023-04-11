import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/shared/blocs/data/data_bloc.dart';
import 'package:predi_v2/shared/blocs/data/data_event.dart';
import 'package:predi_v2/shared/models/enums/data_type_enum.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../../../shared/blocs/data/data_state.dart';
import 'app_progress_indicator.dart';

class AppDataBuilder extends StatelessWidget {
  final PatientModel patient;
  final DataTypeEnum dataTypeToLoad;
  final DataTypeEnum dataType;
  final Function(List, DataTypeEnum) child;

  const AppDataBuilder(
      {super.key,
      required this.patient,
      required this.dataTypeToLoad,
      required this.dataType,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataBloc()
        ..add(
          LoadDataRequested(patient: patient, dataType: dataTypeToLoad),
        ),
      child: BlocBuilder<DataBloc, DataState>(
        builder: ((context, state) {
          if (state is LoadingData) {
            return const Center(
              child: AppProgressIndicator(),
            );
          }
          if (state is Error) {
            return const Center(
              child: Text('Não foi possivel carregar os dados'),
            );
          }
          if (state is DataLoaded) {
            var dataList = state.dataList;
            if (dataList.isEmpty) {
              return Center(
                  child: Text(
                      'Não há dados de ${dataType.secondaryTitle.toLowerCase()}'));
            } else {
              return child(state.dataList, dataType);
            }
          }
          return const Center(child: Text('Erro desconhecido'));
        }),
      ),
    );
  }
}
