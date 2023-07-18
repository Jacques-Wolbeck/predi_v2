import 'package:flutter/material.dart';
import 'package:predi_v2/android/widgets/buttons/update_buttons/rates_button.dart';
import 'package:predi_v2/android/widgets/commons/app_data_builder.dart';
import 'package:predi_v2/android/widgets/commons/app_line_chart.dart';
import 'package:predi_v2/android/widgets/commons/app_rate_information.dart';
import 'package:predi_v2/android/widgets/commons/app_screen_args.dart';
import 'package:predi_v2/android/widgets/fields/rate_field.dart';

import 'package:predi_v2/shared/models/enums/data_type_enum.dart';

import '../../../shared/models/patients/patient_model.dart';

class RatesScreen extends StatefulWidget {
  final PatientModel patient;
  const RatesScreen({super.key, required this.patient});

  @override
  State<RatesScreen> createState() => _RatesScreenState();
}

class _RatesScreenState extends State<RatesScreen> {
  final _formKey = GlobalKey<FormState>();
  final glycatedFocus = FocusNode();
  final fastingFocus = FocusNode();
  final glucose75Focus = FocusNode();

  @override
  void initState() {
    glycatedFocus.addListener(() => setState(() {}));
    fastingFocus.addListener(() => setState(() {}));
    glucose75Focus.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          title: const Text('Taxas'),
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
                  Text(DataTypeEnum.glycatedHemoglobin.primaryTitle)
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.show_chart),
                  Text(DataTypeEnum.fastingGlucose.primaryTitle),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.show_chart),
                  Text(DataTypeEnum.glucose75g.primaryTitle),
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
                  _rateTextForm(
                      DataTypeEnum.glycatedHemoglobin,
                      '4.0',
                      glycatedFocus,
                      fastingFocus,
                      (value) => widget.patient.glycatedHemoglobin =
                          double.parse(value!)),
                  const SizedBox(width: 4.0),
                  _rateTextForm(
                      DataTypeEnum.fastingGlucose,
                      '90.0',
                      fastingFocus,
                      glucose75Focus,
                      (value) =>
                          widget.patient.fastingGlucose = double.parse(value!)),
                  const SizedBox(width: 4.0),
                  _rateTextForm(
                      DataTypeEnum.glucose75g,
                      '90.0',
                      glucose75Focus,
                      null,
                      (value) =>
                          widget.patient.glucose75g = double.parse(value!)),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RatesButton(formKey: _formKey),
                ElevatedButton(
                    onPressed: () {
                      glycatedFocus.unfocus();
                      glucose75Focus.unfocus();
                      fastingFocus.unfocus();
                      Navigator.pushNamed(context, '/rates_list_screen',
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
            const AppRateInformation(),
            const Divider(),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  AppDataBuilder(
                      patient: widget.patient,
                      dataTypeToLoad: DataTypeEnum.rate,
                      dataType: DataTypeEnum.glycatedHemoglobin,
                      child: _tabViewContent),
                  AppDataBuilder(
                      patient: widget.patient,
                      dataTypeToLoad: DataTypeEnum.rate,
                      dataType: DataTypeEnum.fastingGlucose,
                      child: _tabViewContent),
                  AppDataBuilder(
                      patient: widget.patient,
                      dataTypeToLoad: DataTypeEnum.rate,
                      dataType: DataTypeEnum.glucose75g,
                      child: _tabViewContent)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '5 últimas taxas',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const Icon(Icons.opacity_outlined, size: 12.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _rateTextForm(
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
          RateField(
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
