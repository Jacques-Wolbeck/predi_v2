import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:predi_v2/android/widgets/commons/app_data_builder.dart';
import 'package:predi_v2/shared/models/enums/data_type_enum.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../../../shared/blocs/data/data_bloc.dart';
import '../../../shared/blocs/data/data_state.dart';
import '../../../shared/models/patients/rate_model.dart';
import '../../widgets/bottom_sheets/edit_rates_bottom_sheet.dart';
import '../../widgets/buttons/delete_button.dart';
import '../../widgets/alerts/simple_alert.dart';
import '../../widgets/commons/app_snack_bar.dart';

class RatesListScreen extends StatefulWidget {
  final PatientModel patient;
  const RatesListScreen({super.key, required this.patient});

  @override
  State<RatesListScreen> createState() => _RatesListScreenState();
}

//TODO Its necessary to update patient data, when the rate is alterated
class _RatesListScreenState extends State<RatesListScreen> {
  final deleteList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: const Text('Detalhes de Taxas'),
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
                            'Toque em uma taxa para edita-la ou toque e segure para deleta-la.',
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
              dataType: DataTypeEnum.rate,
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
          dataTypeToLoad: DataTypeEnum.rate,
          dataType: DataTypeEnum.rate,
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
          var rate = dataList[index] as RateModel;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
                borderRadius: BorderRadius.circular(16.0),
                color: deleteList.contains(rate)
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primaryContainer,
                child: InkWell(
                    onTap: () {
                      if (deleteList.contains(rate)) {
                        deleteList.remove(rate);
                        setState(() {});
                      } else if (deleteList.isNotEmpty) {
                        deleteList.add(rate);
                        setState(() {});
                      } else {
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
                              return EditRatesBottomSheet(rate: rate);
                            });
                      }
                    },
                    onLongPress: () {
                      if (!deleteList.contains(rate)) {
                        deleteList.add(rate);
                        setState(() {});
                      }
                    },
                    child: _card(rate))),
          );
        },
      ),
    );
  }

  Widget _card(RateModel rate) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16.0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleContent(DataTypeEnum.glycatedHemoglobin, Icons.opacity,
              rate.glycatedHemoglobin.toString()),
          const Divider(),
          _titleContent(DataTypeEnum.fastingGlucose, Icons.opacity,
              rate.fastingGlucose.toString()),
          const Divider(),
          _titleContent(DataTypeEnum.glucose75g, Icons.opacity,
              rate.glucose75g.toString()),
          const Divider(),
        ],
      ),
      subtitle: Row(
        children: [
          const Icon(Icons.calendar_month_outlined),
          const SizedBox(width: 8.0),
          Text(DateFormat('dd-MM-yyyy').format(rate.date!)),
        ],
      ),
    );
  }

  Widget _titleContent(
      DataTypeEnum dataType, IconData icon, String? measureValue) {
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
