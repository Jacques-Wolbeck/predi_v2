import 'package:flutter/material.dart';
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
            Text(DataTypeEnum.glycatedHemoglobin.value),
            Text(DataTypeEnum.fastingGlucose.value),
            Text(DataTypeEnum.glucose75g.value),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      child: TabBarView(
        children: [
          Center(child: Text(DataTypeEnum.glycatedHemoglobin.value)),
          Center(child: Text(DataTypeEnum.fastingGlucose.value)),
          Center(child: Text(DataTypeEnum.glucose75g.value))
        ],
      ),
    );
  }
}
