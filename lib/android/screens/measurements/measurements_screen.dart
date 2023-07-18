import 'package:flutter/material.dart';

import '../../../shared/models/enums/data_type_enum.dart';
import '../../../shared/models/patients/patient_model.dart';
import '../../widgets/buttons/update_buttons/measurement_button.dart';
import '../../widgets/commons/app_bmi_information.dart';
import '../../widgets/commons/app_data_builder.dart';
import '../../widgets/commons/app_line_chart.dart';
import '../../widgets/commons/app_screen_args.dart';
import '../../widgets/fields/measure_field.dart';

class MeasurementsScreen extends StatefulWidget {
  final PatientModel patient;
  const MeasurementsScreen({super.key, required this.patient});

  @override
  State<MeasurementsScreen> createState() => _MeasurementsScreenState();
}

class _MeasurementsScreenState extends State<MeasurementsScreen> {
  final _formKey = GlobalKey<FormState>();
  final weightFocus = FocusNode();
  final circumferenceFocus = FocusNode();

  @override
  void initState() {
    weightFocus.addListener(() => setState(() {}));
    circumferenceFocus.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          title: const Text('Medidas'),
        ),
        body: _body(),
        bottomNavigationBar: Material(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: TabBar(
            labelPadding: const EdgeInsets.all(4.0),
            indicatorWeight: 2.0,
            tabs: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.show_chart),
                  Text(DataTypeEnum.weight.primaryTitle)
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.show_chart),
                  Text(DataTypeEnum.circumference.primaryTitle),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Row(
                children: [
                  _measureTextForm(
                      DataTypeEnum.weight,
                      '65.0',
                      weightFocus,
                      circumferenceFocus,
                      (value) => widget.patient.weight = double.parse(value!)),
                  const SizedBox(width: 4.0),
                  _measureTextForm(
                      DataTypeEnum.circumference,
                      '95.0',
                      circumferenceFocus,
                      null,
                      (value) =>
                          widget.patient.circumference = double.parse(value!)),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MeasurementButton(formKey: _formKey),
                ElevatedButton(
                    onPressed: () {
                      weightFocus.unfocus();
                      circumferenceFocus.unfocus();
                      Navigator.pushNamed(context, '/measurements_list_screen',
                          arguments:
                              DefaultScreenArguments(patient: widget.patient));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Detalhes'))
              ],
            ),
            const SizedBox(height: 16.0),
            const AppBmiInformation(),
            const Divider(),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  AppDataBuilder(
                      patient: widget.patient,
                      dataTypeToLoad: DataTypeEnum.measure,
                      dataType: DataTypeEnum.weight,
                      child: _tabViewContent),
                  AppDataBuilder(
                      patient: widget.patient,
                      dataTypeToLoad: DataTypeEnum.measure,
                      dataType: DataTypeEnum.circumference,
                      child: _tabViewContent),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '5 últimas medidas',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const Icon(Icons.straighten_outlined, size: 12.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _measureTextForm(
      DataTypeEnum dataType,
      String hintText,
      FocusNode currentFocus,
      FocusNode? nextFocus,
      Function(String?) onSavedCallback) {
    return Expanded(
      child: Column(
        children: [
          Text(
            dataType.primaryTitle,
            style: TextStyle(
                color: currentFocus.hasFocus
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black),
          ),
          MeasureField(
            onSavedCallback: onSavedCallback,
            dataType: dataType,
            hintText: hintText,
            currentFocus: currentFocus,
            nextFocus: nextFocus,
          ),
          Text(
            dataType.measurementUnit!,
            style: TextStyle(
                color: currentFocus.hasFocus
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black),
          )
        ],
      ),
    );
  }

  Widget _tabViewContent(List dataList, DataTypeEnum dataType) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppLineChart(
        dataList: dataList,
        dataType: dataType,
      ),
    );
  }
}
