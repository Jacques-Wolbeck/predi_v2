import 'package:flutter/material.dart';
import 'package:predi_v2/android/widgets/bottom_sheets/home_bottom_sheet.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

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
              icon: Icon(Icons.favorite_border),
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
                _tabContent(),
                Center(child: Text('Medidas')),
                Center(child: Text('Consultas'))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _tabContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.0),
              height: MediaQuery.of(context).size.height * .2,
              width: MediaQuery.of(context).size.width * .3,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.opacity,
                    size: 40.0,
                  ),
                  const Text('Hb1A1C'),
                  widget.patient.glycatedHemoglobin == null
                      ? const Text('0.00%')
                      : Text('${widget.patient.glycatedHemoglobin}%'),
                ],
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.0),
              height: MediaQuery.of(context).size.height * .2,
              width: MediaQuery.of(context).size.width * .3,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.opacity,
                    size: 40.0,
                  ),
                  const Text('Jejum'),
                  widget.patient.glycatedHemoglobin == null
                      ? const Text('0.00 mg/dL')
                      : Text('${widget.patient.fastingGlucose}mg/dL'),
                ],
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.0),
              height: MediaQuery.of(context).size.height * .2,
              width: MediaQuery.of(context).size.width * .3,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.opacity,
                    size: 40.0,
                  ),
                  const Text('Jejum'),
                  widget.patient.glycatedHemoglobin == null
                      ? const Text('0.00 mg/dL')
                      : Text('${widget.patient.glucose75g}mg/dL'),
                ],
              ),
            ),
          ],
        ),
        ElevatedButton(
            onPressed: () => null, child: const Text('Atualize suas taxas')),
      ],
    );
  }
}
