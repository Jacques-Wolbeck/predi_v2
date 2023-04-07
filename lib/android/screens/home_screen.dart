import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/android/widgets/bottom_sheets/home_bottom_sheet.dart';
import 'package:predi_v2/android/widgets/commons/alerts/simple_alert.dart';
import 'package:predi_v2/android/widgets/commons/app_report_information.dart';
import 'package:predi_v2/android/widgets/tabs/home_tab_content.dart';
import 'package:predi_v2/shared/blocs/patient/patient_state.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../../shared/blocs/patient/patient_bloc.dart';
import '../../shared/models/enums/data_type_enum.dart';
import '../widgets/commons/app_snack_bar.dart';

class HomeScreen extends StatefulWidget {
  final PatientModel patient;
  const HomeScreen({super.key, required this.patient});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//TODO after update the patient data for second time, the snack bar is triggered twice
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          centerTitle: true,
          title: const Text('PreDi'),
          leading: IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const SimpleAlert(
                        title: 'Informativo',
                        content:
                            'Pressione o coração para obter um pré diagnóstico gerado a partir das suas taxas informadas.',
                        button2Text: 'Voltar',
                      );
                    });
              }),
          actions: [
            IconButton(
              onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0)),
                  ),
                  builder: (context) {
                    return HomeBottomSheet(patient: widget.patient);
                  }),
              icon: const Icon(Icons.menu),
            ),
          ],
        ),
        body: BlocListener<PatientBloc, PatientState>(
          listener: (context, state) {
            if (state is Updated) {
              ScaffoldMessenger.of(context).showSnackBar(
                  AppSnackBar(message: state.message).snack(context));
            }
            if (state is PatientError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  AppSnackBar(message: state.error, isError: true)
                      .snack(context));
            }
          },
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: AppReportInformation(
              patient: widget.patient,
            ),
          ),
          const PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: TabBar(
              tabs: [
                Tab(text: 'Taxas', icon: Icon(Icons.opacity)),
                Tab(text: 'Medidas', icon: Icon(Icons.straighten)),
                Tab(text: 'Consultas', icon: Icon(Icons.calendar_month)),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: TabBarView(
              children: [
                Center(
                  child: HomeTabContent(
                      patient: widget.patient, dataType: DataTypeEnum.rate),
                ),
                Center(
                  child: HomeTabContent(
                      patient: widget.patient, dataType: DataTypeEnum.measure),
                ),
                Center(child: Text(DataTypeEnum.appointment.value1))
              ],
            ),
          )
        ],
      ),
    );
  }
}
