import 'package:flutter/material.dart';
import 'package:predi_v2/shared/models/enums/data_type_enum.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../commons/app_screen_args.dart';

class HomeTabContent extends StatelessWidget {
  final PatientModel patient;
  final DataTypeEnum dataType;

  const HomeTabContent({
    super.key,
    required this.patient,
    required this.dataType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        dataType == DataTypeEnum.rate
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _content(
                      context,
                      Icons.opacity,
                      DataTypeEnum.glycatedHemoglobin,
                      patient.glycatedHemoglobin),
                  _content(context, Icons.opacity, DataTypeEnum.fastingGlucose,
                      patient.fastingGlucose),
                  _content(context, Icons.opacity, DataTypeEnum.glucose75g,
                      patient.glucose75g)
                ],
              )
            : Row(
                children: [
                  _content(context, Icons.monitor_weight_outlined,
                      DataTypeEnum.weight, patient.weight),
                  _content(context, Icons.scale, DataTypeEnum.bmi, patient.bmi),
                  _content(context, Icons.straighten,
                      DataTypeEnum.circumference, patient.circumference)
                ],
              ),
        ElevatedButton(
            onPressed: () {
              if (dataType == DataTypeEnum.rate) {
                Navigator.pushNamed(context, '/rates_screen',
                    arguments: DefaultScreenArguments(patient: patient));
              }
            },
            child: Text('Atualize suas ${dataType.primaryTitle}')),
      ],
    );
  }

  Widget _content(BuildContext context, IconData icon, DataTypeEnum dataType,
      double? value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.0),
      padding: const EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * .2,
      width: MediaQuery.of(context).size.width * .3,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40.0,
          ),
          Text(dataType.primaryTitle),
          _getText(dataType, value),
        ],
      ),
    );
  }

  Widget _getText(DataTypeEnum dataType, double? value) {
    if (value != null) {
      if (dataType == DataTypeEnum.bmi) {
        return Text(
            '${value.toStringAsPrecision(4)} ${dataType.measurementUnit}${String.fromCharCode(178)}');
      } else {
        return Text('$value ${dataType.measurementUnit}');
      }
    } else {
      if (dataType == DataTypeEnum.bmi) {
        return Text(
            '0.00 ${dataType.measurementUnit}${String.fromCharCode(178)}');
      } else {
        return Text('0.00 ${dataType.measurementUnit}');
      }
    }
  }
}
