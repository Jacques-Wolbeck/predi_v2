import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/android/widgets/buttons/update_buttons/consultation_button.dart';
import 'package:predi_v2/android/widgets/commons/app_data_builder.dart';
import 'package:predi_v2/android/widgets/fields/date_time_field.dart';
import 'package:predi_v2/shared/controllers/firebase/firebase_db.dart';
import 'package:predi_v2/shared/models/patients/consultation_model.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../../../shared/blocs/data/data_bloc.dart';
import '../../../shared/blocs/data/data_state.dart';
import '../../../shared/models/enums/data_type_enum.dart';
import '../../widgets/commons/alerts/simple_alert.dart';
import '../../widgets/commons/app_snack_bar.dart';
import '../../widgets/fields/default_field.dart';

class ConsultationsScreen extends StatefulWidget {
  final PatientModel patient;
  const ConsultationsScreen({super.key, required this.patient});

  @override
  State<ConsultationsScreen> createState() => _ConsultationsScreenState();
}

//TODO After complete the datetime field, the field still keps the focus

class _ConsultationsScreenState extends State<ConsultationsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _consultation = ConsultationModel();
  final localFocus = FocusNode();
  final examTypeFocus = FocusNode();
  final dataFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: const Text('Consultas Médicas'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const SimpleAlert(
                        title: "Informativo",
                        content:
                            "As consultadas serão deletadas automaticamente, conforme suas datas definidas forem alcançadas.",
                        button2Text: "Voltar",
                      );
                    });
              }),
        ],
      ),
      body: BlocListener<DataBloc, DataState>(
        listener: (context, state) {
          if (state is Concluded) {
            ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(message: state.feedbackMessage).snack(context));
          }
          if (state is DataError) {
            ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(message: state.error, isError: true)
                    .snack(context));
          }
        },
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  DefaultField(
                    labelText: 'Local',
                    hintText: 'Clínica/Hospital',
                    prefixIcon: Icons.local_hospital_outlined,
                    onSavedCallback: (value) => _consultation.local = value,
                    currentFocus: localFocus,
                    nextFocus: examTypeFocus,
                  ),
                  DefaultField(
                    labelText: 'Tipo de exame',
                    hintText: 'Exame de Glicemia, TTG...',
                    prefixIcon: Icons.medical_information_outlined,
                    onSavedCallback: (value) => _consultation.examType = value,
                    currentFocus: examTypeFocus,
                    nextFocus: dataFocus,
                  ),
                  DateTimeField(
                      onSavedCallback: (value) {
                        dataFocus.unfocus();
                        _consultation.date = value;
                      },
                      currentFocus: dataFocus),
                ],
              ),
            ),
            ConsultationButton(formKey: _formKey, consultation: _consultation),
            const Divider(),
            AppDataBuilder(
                patient: widget.patient,
                dataTypeToLoad: DataTypeEnum.consultation,
                dataType: DataTypeEnum.consultation,
                child: _consultationsList),
          ],
        ),
      ),
    );
  }

  Widget _consultationsList(List consultations, DataTypeEnum dataType) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: consultations.length,
        itemBuilder: (context, index) {
          var consultation = consultations[index] as ConsultationModel;
          //TODO auto delete old consultations
          /*if (DateTime.now().isAfter(consultation.date!)) {
            FirebaseDb.instance
                .delete(widget.patient, dataType, [consultation]);
          }*/
          return Card(
            child: ListTile(
              title: Text(consultation.local!),
            ),
          );
        });
  }
}
