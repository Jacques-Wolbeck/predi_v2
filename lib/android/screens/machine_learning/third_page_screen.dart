import 'package:flutter/material.dart';

import '../../../shared/models/enums/survey_content_enum.dart';
import '../../widgets/buttons/survey_buttons/binary_button.dart';

class ThirdPageScreen extends StatefulWidget {
  final Function(String, int) updateSurvey;
  const ThirdPageScreen({super.key, required this.updateSurvey});

  @override
  State<ThirdPageScreen> createState() => _ThirdPageScreenState();
}

class _ThirdPageScreenState extends State<ThirdPageScreen> {
  final List<bool> _selectedPhysActivityOption = <bool>[false, true];
  final List<bool> _selectedGenHlthOption = <bool>[
    true,
    false,
    false,
    false,
    false
  ];
  final List<bool> _selectedDiffWalkOption = <bool>[false, true];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_firstQuestion(), _secondQuestion(), _thirdQuestion()],
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
            SurveyContentEnum.genHlth.description,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          BinaryButton(
            selectedOption: _selectedGenHlthOption,
            onPressed: (index) {
              setState(() {
                for (int i = 0; i < _selectedGenHlthOption.length; i++) {
                  if (i == index) {
                    _selectedGenHlthOption[i] = true;
                  } else {
                    _selectedGenHlthOption[i] = false;
                  }
                }
              });
              if (_selectedGenHlthOption[0]) {
                widget.updateSurvey('genHlth', 1);
              } else if (_selectedGenHlthOption[1]) {
                widget.updateSurvey('genHlth', 2);
              } else if (_selectedGenHlthOption[2]) {
                widget.updateSurvey('genHlth', 3);
              } else if (_selectedGenHlthOption[3]) {
                widget.updateSurvey('genHlth', 4);
              } else if (_selectedGenHlthOption[4]) {
                widget.updateSurvey('genHlth', 5);
              } else {
                widget.updateSurvey('genHlth', 1);
              }
            },
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('1 - Excelente'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('2 - Muito Bom'),
              ),
              Text('3 - Bom'),
              Text('4 - Pobre'),
              Text('5 - Ruim')
            ],
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
            SurveyContentEnum.diffWalk.description,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          BinaryButton(
            selectedOption: _selectedDiffWalkOption,
            onPressed: (index) {
              setState(() {
                for (int i = 0; i < _selectedDiffWalkOption.length; i++) {
                  if (i == index) {
                    _selectedDiffWalkOption[i] = true;
                  } else {
                    _selectedDiffWalkOption[i] = false;
                  }
                }
              });
              if (_selectedDiffWalkOption[0]) {
                widget.updateSurvey('diffWalk', 1);
              } else {
                widget.updateSurvey('diffWalk', 0);
              }
            },
            children: const [Text('Sim'), Text('Não')],
          )
        ],
      ),
    );
  }

  Widget _thirdQuestion() {
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
            SurveyContentEnum.physActivity.description,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          BinaryButton(
              selectedOption: _selectedPhysActivityOption,
              onPressed: (index) {
                setState(() {
                  for (int i = 0; i < _selectedPhysActivityOption.length; i++) {
                    if (i == index) {
                      _selectedPhysActivityOption[i] = true;
                    } else {
                      _selectedPhysActivityOption[i] = false;
                    }
                  }
                });
                if (_selectedPhysActivityOption[0]) {
                  widget.updateSurvey('physActivity', 1);
                } else {
                  widget.updateSurvey('physActivity', 0);
                }
              },
              children: const [Text('Sim'), Text('Não')])
        ],
      ),
    );
  }
}
