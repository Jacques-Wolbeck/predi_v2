import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../shared/blocs/data/data_bloc.dart';
import '../../../shared/blocs/data/data_state.dart';
import '../../../shared/models/enums/data_type_enum.dart';
import '../../../shared/models/patients/measurement_model.dart';
import '../../../shared/models/patients/patient_model.dart';
import '../../widgets/bottom_sheets/edit_measures_bottom_sheet.dart';
import '../../widgets/buttons/delete_button.dart';
import '../../widgets/alerts/simple_alert.dart';
import '../../widgets/commons/app_data_builder.dart';
import '../../widgets/commons/app_snack_bar.dart';

class MeasurementsListScreen extends StatefulWidget {
  final PatientModel patient;
  const MeasurementsListScreen({super.key, required this.patient});

  @override
  State<MeasurementsListScreen> createState() => _MeasurementsListScreenState();
}

class _MeasurementsListScreenState extends State<MeasurementsListScreen> {
  final deleteList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: const Text('Detalhes de Medidas'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const SimpleAlert(
                        title: 'Informativo',
                        content:
                            'Toque em uma medida para edita-la ou toque e segure para deleta-la.',
                        button2Text: 'Voltar',
                      );
                    });
              },
              icon: const Icon(Icons.info_outline))
        ],
      ),
      floatingActionButton: deleteList.isNotEmpty
          ? DeleteButton(
              deleteList: deleteList,
              onChanged: () => setState(() {}),
              dataType: DataTypeEnum.measure,
            )
          : const SizedBox.shrink(),
      body: BlocListener<DataBloc, DataState>(
        listener: (context, state) {
          if (state is Concluded) {
            if (deleteList.isNotEmpty) {
              setState(() {
                deleteList.clear();
              });
            }
            ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(message: state.feedbackMessage).snack(context));
          }
          if (state is DataError) {
            ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(message: state.error, isError: true)
                    .snack(context));
          }
        },
        child: AppDataBuilder(
          patient: widget.patient,
          dataTypeToLoad: DataTypeEnum.measure,
          dataType: DataTypeEnum.measure,
          child: _body,
        ),
      ),
    );
  }

  Widget _body(List dataList, DataTypeEnum dataType) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          var measure = dataList[index] as MeasurementModel;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
                borderRadius: BorderRadius.circular(16.0),
                color: deleteList.contains(measure)
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primaryContainer,
                child: InkWell(
                    onTap: () {
                      if (deleteList.contains(measure)) {
                        deleteList.remove(measure);
                        setState(() {});
                      } else if (deleteList.isNotEmpty) {
                        deleteList.add(measure);
                        setState(() {});
                      } else {
                        /*showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return EditMeasurementsAlert(measure: measure);
                            });*/
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            isDismissible: false,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  topRight: Radius.circular(16.0)),
                            ),
                            builder: (context) {
                              return EditMeasuresBottomSheet(measure: measure);
                            });
                      }
                    },
                    onLongPress: () {
                      if (!deleteList.contains(measure)) {
                        deleteList.add(measure);
                        setState(() {});
                      }
                    },
                    child: _card(measure))),
          );
        },
      ),
    );
  }

  Widget _card(MeasurementModel measure) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16.0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleContent(DataTypeEnum.weight, Icons.monitor_weight_outlined,
              measure.weight.toString()),
          const Divider(),
          _titleContent(DataTypeEnum.circumference, Icons.straighten,
              measure.circumference.toString()),
          const Divider(),
          _titleContent(
              DataTypeEnum.bmi,
              Icons.accessibility_new_outlined,
              (measure.weight! /
                      (widget.patient.height! * widget.patient.height!))
                  .toStringAsFixed(2)),
          const Divider(),
        ],
      ),
      subtitle: Row(
        children: [
          const Icon(Icons.calendar_month_outlined),
          const SizedBox(width: 8.0),
          Text(DateFormat('dd-MM-yyyy').format(measure.date!)),
        ],
      ),
    );
  }

  Widget _titleContent(
      DataTypeEnum dataType, IconData? icon, String? measureValue) {
    return Wrap(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 8.0),
        Wrap(
          children: [
            Text(
              '${dataType.secondaryTitle}: ',
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
            Text(
              '$measureValue ${dataType.measurementUnit!}',
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
          ],
        )
      ],
    );
  }
}
