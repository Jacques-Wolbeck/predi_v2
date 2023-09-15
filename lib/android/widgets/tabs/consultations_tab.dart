import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:predi_v2/android/widgets/commons/app_data_builder.dart';
import 'package:predi_v2/shared/models/patients/consultation_model.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../../../shared/models/enums/data_type_enum.dart';
import '../commons/app_screen_args.dart';

class ConsultationsTab extends StatefulWidget {
  final PatientModel patient;
  const ConsultationsTab({super.key, required this.patient});

  @override
  State<ConsultationsTab> createState() => _ConsultationsTabState();
}

class _ConsultationsTabState extends State<ConsultationsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * .2,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                blurRadius: .5,
                offset: const Offset(1.0, 1.0),
                color: Theme.of(context).colorScheme.shadow,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 40.0,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "Próxima\n${DataTypeEnum.consultation.secondaryTitle}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4.0),
              AppDataBuilder(
                  patient: widget.patient,
                  dataTypeToLoad: DataTypeEnum.consultation,
                  dataType: DataTypeEnum.consultation,
                  child: _text)
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/consultations_screen',
              arguments: DefaultScreenArguments(patient: widget.patient)),
          style: ElevatedButton.styleFrom(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Text('Cadastrar ${DataTypeEnum.consultation.primaryTitle}',
              style: const TextStyle(fontWeight: FontWeight.bold)),
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
          Text(
            consultation.local!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
          Text(
            consultation.examType!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
          Text(
            DateFormat('dd/MM/yyyy - HH:mm').format(consultation.date!),
            style: TextStyle(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          )
        ],
      ),
    );
  }
}
