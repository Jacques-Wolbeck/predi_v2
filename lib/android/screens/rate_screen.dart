import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:predi_v2/android/widgets/commons/app_rate_information.dart';
import 'package:predi_v2/android/widgets/fields/rate_field.dart';
import 'package:predi_v2/shared/models/enums/data_type_enum.dart';

import '../../shared/models/patients/patient_model.dart';

class RateScreen extends StatefulWidget {
  final PatientModel patient;
  const RateScreen({super.key, required this.patient});

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
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
        bottomNavigationBar: TabBar(
          tabs: [
            Text(DataTypeEnum.glycatedHemoglobin.value1),
            Text(DataTypeEnum.fastingGlucose.value1),
            Text(DataTypeEnum.glucose75g.value1),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      child: TabBarView(
        children: [
          _tabViewContent(DataTypeEnum.glycatedHemoglobin,
              widget.patient.glycatedHemoglobin!, '4.4'),
          _tabViewContent(DataTypeEnum.fastingGlucose,
              widget.patient.fastingGlucose, '80.0'),
          _tabViewContent(
              DataTypeEnum.glucose75g, widget.patient.glucose75g, '80.0'),
        ],
      ),
    );
  }

  Widget _tabViewContent(
      DataTypeEnum dataType, double? currentValue, String hintText) {
    currentValue = currentValue ?? 0.00;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16.0),
        dataType != DataTypeEnum.glycatedHemoglobin
            ? Text('${dataType.value2} atual: ${currentValue.toString()} mg/dL')
            : Text('${dataType.value2} atual: ${currentValue.toString()} %'),
        RateField(
          onSavedCallback: (value) => debugPrint('Apertou'),
          dataType: dataType,
          hintText: hintText,
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () => null, child: const Text('Atualizar')),
            ElevatedButton(onPressed: () => null, child: const Text('Detalhes'))
          ],
        ),
        const SizedBox(height: 16.0),
        const AppRateInformation(),
        const Divider(),
        Expanded(
          child: LineGraph(
            features: features,
            size: Size(420, 450),
            labelX: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6'],
            labelY: ['25%', '45%', '65%', '75%', '85%', '100%'],
            showDescription: true,
            graphColor: Colors.black87,
          ),
        ),
        SizedBox(
          height: 8.0,
        )
      ],
    );
  }

  final List<Feature> features = [
    Feature(
      title: "Flutter",
      color: Colors.blue,
      data: [0.3, 0.6, 0.8, 0.9, 1, 1.2],
    )
  ];
}
