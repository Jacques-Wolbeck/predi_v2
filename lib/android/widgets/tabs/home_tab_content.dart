import 'package:flutter/material.dart';
import 'package:predi_v2/shared/models/patients/enums/data_type_enum.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

class HomeTabContent extends StatelessWidget {
  final PatientModel patient;
  final DataTypeEnum title;

  const HomeTabContent({
    super.key,
    required this.patient,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        title == DataTypeEnum.rate
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _content(
                      context, Icons.opacity, DataTypeEnum.glycatedHemoglobin),
                  _content(context, Icons.opacity, DataTypeEnum.fastingGlucose),
                  _content(context, Icons.opacity, DataTypeEnum.glucose75g)
                ],
              )
            : Row(
                children: [
                  _content(context, Icons.straighten, DataTypeEnum.weight),
                  _content(context, Icons.straighten, DataTypeEnum.bmi),
                  _content(
                      context, Icons.straighten, DataTypeEnum.circumference)
                ],
              ),
        ElevatedButton(
            onPressed: () => null, child: Text('Atualize suas ${title.value}')),
      ],
    );
  }

  Widget _content(BuildContext context, IconData icon, DataTypeEnum dataType) {
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
          Text(dataType.value),
          _getText(dataType),
        ],
      ),
    );
  }

  Widget _getText(DataTypeEnum dataType) {
    switch (dataType) {
      case DataTypeEnum.glycatedHemoglobin:
        return patient.glycatedHemoglobin == null
            ? const Text('0.00 %')
            : Text('${patient.glycatedHemoglobin}%');
      case DataTypeEnum.fastingGlucose:
        return patient.fastingGlucose == null
            ? const Text('0.00 mg/dL')
            : Text('${patient.fastingGlucose} mg/dL');
      case DataTypeEnum.glucose75g:
        return patient.glucose75g == null
            ? const Text('0.00 mg/dL')
            : Text('${patient.glucose75g} mg/dL');
      case DataTypeEnum.weight:
        return patient.weight == null
            ? const Text('0.00 kg')
            : Text('${patient.weight} kg');
      case DataTypeEnum.bmi:
        return patient.weight == null
            ? Text('0.00 kg/m${String.fromCharCode(178)}')
            : Text(
                '${patient.bmi!.toStringAsPrecision(4)} kg/m${String.fromCharCode(178)}');
      case DataTypeEnum.circumference:
        return patient.circumference == null
            ? const Text('0.00 cm')
            : Text('${patient.circumference} cm');
      default:
        return const Text('-');
    }
  }
}
