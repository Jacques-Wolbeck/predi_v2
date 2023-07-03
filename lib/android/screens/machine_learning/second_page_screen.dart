import 'package:flutter/material.dart';

import '../../../shared/models/enums/survey_content_enum.dart';
import '../../widgets/buttons/survey_buttons/binary_button.dart';

class SecondPageScreen extends StatefulWidget {
  final Function(String, int) updateSurvey;
  const SecondPageScreen({super.key, required this.updateSurvey});

  @override
  State<SecondPageScreen> createState() => _SecondPageScreenState();
}

class _SecondPageScreenState extends State<SecondPageScreen> {
  final List<bool> _selectedCholCheckOption = <bool>[false, true];
  final List<bool> _selectedHeartDiseaseOption = <bool>[false, true];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _firstQuestion(),
        _secondQuestion(),
      ],
    );
  }

  Widget _firstQuestion() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              blurRadius: .2,
              offset: const Offset(.5, .5),
              color: Theme.of(context).colorScheme.shadow,
            )
          ]),
      child: Column(
        children: [
          Text(
            SurveyContentEnum.cholCheck.description,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          BinaryButton(
            selectedOption: _selectedCholCheckOption,
            onPressed: (index) {
              setState(() {
                for (int i = 0; i < _selectedCholCheckOption.length; i++) {
                  if (i == index) {
                    _selectedCholCheckOption[i] = true;
                  } else {
                    _selectedCholCheckOption[i] = false;
                  }
                }
              });
              if (_selectedCholCheckOption[0]) {
                widget.updateSurvey('cholCheck', 1);
              } else {
                widget.updateSurvey('cholCheck', 0);
              }
            },
            children: const [Text('Sim'), Text('Não')],
          )
        ],
      ),
    );
  }

  Widget _secondQuestion() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              blurRadius: .2,
              offset: const Offset(.5, .5),
              color: Theme.of(context).colorScheme.shadow,
            )
          ]),
      child: Column(
        children: [
          Text(
            SurveyContentEnum.heartDiseaseorAttack.description,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          BinaryButton(
            selectedOption: _selectedHeartDiseaseOption,
            onPressed: (index) {
              setState(() {
                for (int i = 0; i < _selectedHeartDiseaseOption.length; i++) {
                  if (i == index) {
                    _selectedHeartDiseaseOption[i] = true;
                  } else {
                    _selectedHeartDiseaseOption[i] = false;
                  }
                }
              });
              if (_selectedHeartDiseaseOption[0]) {
                widget.updateSurvey('heartDiseaseorAttack', 1);
              } else {
                widget.updateSurvey('heartDiseaseorAttack', 0);
              }
            },
            children: const [Text('Sim'), Text('Não')],
          )
        ],
      ),
    );
  }
}
