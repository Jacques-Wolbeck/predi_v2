import 'package:flutter/material.dart';
import 'package:predi_v2/android/widgets/bottom_sheets/home_bottom_sheet.dart';
import 'package:predi_v2/android/widgets/tabs/home_tab_content.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../../shared/models/patients/enums/data_type_enum.dart';

class HomeScreen extends StatefulWidget {
  final PatientModel patient;
  const HomeScreen({super.key, required this.patient});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

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
          leading:
              IconButton(icon: const Icon(Icons.info), onPressed: () => null),
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
        body: _body(),
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
            child: IconButton(
              onPressed: () => null,
              icon: const Icon(Icons.favorite_border),
              iconSize: MediaQuery.of(context).size.height * .25,
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
                      patient: widget.patient, title: DataTypeEnum.rate),
                ),
                Center(
                  child: HomeTabContent(
                      patient: widget.patient, title: DataTypeEnum.measure),
                ),
                Center(child: Text(DataTypeEnum.appointment.value))
              ],
            ),
          )
        ],
      ),
    );
  }
}
