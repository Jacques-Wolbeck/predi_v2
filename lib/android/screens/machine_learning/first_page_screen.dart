import 'package:flutter/material.dart';
import 'package:predi_v2/android/widgets/buttons/survey_buttons/binary_button.dart';

import '../../../shared/models/enums/survey_content_enum.dart';

class FirstPageScreen extends StatefulWidget {
  final Function(String, int) updateSurvey;
  const FirstPageScreen({super.key, required this.updateSurvey});

  @override
  State<FirstPageScreen> createState() => _FirstPageScreenState();
}

class _FirstPageScreenState extends State<FirstPageScreen> {
  final List<bool> _selectedBpOption = <bool>[false, true];
  final List<bool> _selectedCholOption = <bool>[false, true];

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
            SurveyContentEnum.highBp.description,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          BinaryButton(
            selectedOption: _selectedBpOption,
            onPressed: (index) {
              setState(() {
                for (int i = 0; i < _selectedBpOption.length; i++) {
                  if (i == index) {
                    _selectedBpOption[i] = true;
                  } else {
                    _selectedBpOption[i] = false;
                  }
                }
              });
              if (_selectedBpOption[0]) {
                widget.updateSurvey('highBp', 1);
              } else {
                widget.updateSurvey('highBp', 0);
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
            SurveyContentEnum.highChol.description,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          BinaryButton(
            selectedOption: _selectedCholOption,
            onPressed: (index) {
              setState(() {
                for (int i = 0; i < _selectedCholOption.length; i++) {
                  if (i == index) {
                    _selectedCholOption[i] = true;
                  } else {
                    _selectedCholOption[i] = false;
                  }
                }
              });
              if (_selectedCholOption[0]) {
                widget.updateSurvey('highChol', 1);
              } else {
                widget.updateSurvey('highChol', 0);
              }
            },
            children: const [Text('Sim'), Text('Não')],
          )
        ],
      ),
    );
  }
}
