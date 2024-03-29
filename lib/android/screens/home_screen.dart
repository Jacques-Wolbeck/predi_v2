import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/android/widgets/bottom_sheets/home_bottom_sheet.dart';
import 'package:predi_v2/android/widgets/alerts/simple_alert.dart';
import 'package:predi_v2/android/widgets/commons/app_report_information.dart';
import 'package:predi_v2/android/widgets/commons/app_screen_args.dart';
import 'package:predi_v2/android/widgets/tabs/rates_measures_tab.dart';
import 'package:predi_v2/shared/blocs/patient/patient_state.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../../shared/blocs/patient/patient_bloc.dart';
import '../../shared/models/enums/data_type_enum.dart';
import '../widgets/commons/app_progress_indicator.dart';
import '../widgets/commons/app_snack_bar.dart';
import '../widgets/tabs/consultations_tab.dart';

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
              icon: const Icon(Icons.info_outline),
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
      child: BlocBuilder<PatientBloc, PatientState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 5,
                child: AppReportInformation(
                  patient: widget.patient,
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Tooltip(
                          message: 'Ingestão de água',
                          child: ElevatedButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              '/water_intake_screen',
                              arguments: DefaultScreenArguments(
                                  patient: widget.patient),
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Image.asset(
                                'assets/images/icons/bottle_water_icon.png',
                                height: 50.0,
                                width: 50.0,
                              ),
                            ),
                          ),
                        ),
                        Tooltip(
                          message: 'Dieta',
                          child: ElevatedButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              '/diet_screen',
                              arguments: DefaultScreenArguments(
                                  patient: widget.patient),
                            ),
                            style: ElevatedButton.styleFrom(
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Image.asset(
                                'assets/images/icons/food_icon.png',
                                height: 50.0,
                                width: 50.0,
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
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
              Flexible(flex: 5, child: _dataState(state))
            ],
          );
        },
      ),
    );
  }

  Widget _dataState(PatientState state) {
    if (state is Loading) {
      return const Center(
        child: AppProgressIndicator(),
      );
    }
    if (state is InitialState) {
      return TabBarView(
        children: [
          Center(
            child: RatesAndMeasuresTab(
                patient: widget.patient, dataType: DataTypeEnum.rate),
          ),
          Center(
            child: RatesAndMeasuresTab(
                patient: widget.patient, dataType: DataTypeEnum.measure),
          ),
          Center(child: ConsultationsTab(patient: widget.patient)),
        ],
      );
    }
    if (state is Updated) {
      var patient = state.patient;
      return TabBarView(
        children: [
          Center(
            child: RatesAndMeasuresTab(
                patient: patient, dataType: DataTypeEnum.rate),
          ),
          Center(
            child: RatesAndMeasuresTab(
                patient: patient, dataType: DataTypeEnum.measure),
          ),
          Center(child: ConsultationsTab(patient: widget.patient)),
        ],
      );
    }
    return const Center(child: Text('Erro desconhecido'));
  }
}
