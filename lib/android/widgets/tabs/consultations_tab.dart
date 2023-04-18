import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:predi_v2/android/widgets/commons/app_data_builder.dart';
import 'package:predi_v2/shared/models/patients/consultation_model.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../../../shared/models/enums/data_type_enum.dart';
import '../commons/app_screen_args.dart';

class ConsultationsTab extends StatelessWidget {
  final PatientModel patient;
  const ConsultationsTab({super.key, required this.patient});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * .2,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8.0)),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 40.0,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  Text(
                    "Próxima\n${DataTypeEnum.consultation.secondaryTitle}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4.0),
              AppDataBuilder(
                  patient: patient,
                  dataTypeToLoad: DataTypeEnum.consultation,
                  dataType: DataTypeEnum.consultation,
                  child: _text)
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/consultations_screen',
              arguments: DefaultScreenArguments(patient: patient)),
          child:
              Text('Cadastrar novas ${DataTypeEnum.consultation.primaryTitle}'),
        )
      ],
    );
  }

  Widget _text(List consultations, DataTypeEnum dateType) {
    var consultation = consultations[0] as ConsultationModel;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(consultation.local!),
          Text(consultation.examType!),
          Text(DateFormat('dd/MM/yyyy - HH:mm').format(consultation.date!))
        ],
      ),
    );
  }
}
