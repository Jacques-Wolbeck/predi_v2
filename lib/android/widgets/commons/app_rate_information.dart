import 'package:flutter/material.dart';

class AppRateInformation extends StatefulWidget {
  const AppRateInformation({super.key});

  @override
  State<AppRateInformation> createState() => _AppRateInformationState();
}

class _AppRateInformationState extends State<AppRateInformation>
    with SingleTickerProviderStateMixin<AppRateInformation> {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.info_outline),
          SizedBox(width: 8.0),
          Text("Informações sobre as taxas"),
        ],
      ),
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return _alertDialog(context);
          },
        );
      },
    );
  }

  Widget _alertDialog(BuildContext context) {
    return AlertDialog(
      iconPadding: EdgeInsets.zero,
      icon: _title(),
      content: _content(),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.keyboard_return_outlined),
              SizedBox(width: 4.0),
              Text('Voltar', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _title() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
      ),
      child: TabBar(
        //indicatorColor: Theme.of(context).colorScheme.onPrimary,
        unselectedLabelColor: Theme.of(context).colorScheme.primaryContainer,
        labelColor: Theme.of(context).colorScheme.onSecondary,
        controller: _tabController,
        tabs: const [
          Text("Glicose em Jejum",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Hemoglobina Glicada",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget _content() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
      width: MediaQuery.of(context).size.width * .4,
      child: TabBarView(
        controller: _tabController,
        children: [
          Table(
            children: [
              _tableRow("Menor que 99 md/dL", "Normal"),
              _tableRow("Entre 100 e 125 mg/dL", "Pré-diabetes"),
              _tableRow(
                  "Maior que 126 mg/dL em dois dias diferentes", "Diabetes")
            ],
          ),
          Table(
            children: [
              _tableRow("4.0% a 6.5%", "Excelente Controle"),
              _tableRow("7.0% a 7.5%", "Bom Controle"),
              _tableRow("8.0% ou maior", "Péssimo Controle")
            ],
          ),
        ],
      ),
    );
  }

  TableRow _tableRow(String title1, String title2) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title1,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title2,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
