import 'package:flutter/material.dart';

import '../../../shared/models/enums/survey_content_enum.dart';
import '../../widgets/buttons/survey_buttons/survey_binary_button.dart';
import '../../widgets/buttons/survey_buttons/survey_drop_down_button.dart';

class SecondPageScreen extends StatefulWidget {
  final Function(SurveyContentEnum, dynamic) updateSurvey;
  const SecondPageScreen({super.key, required this.updateSurvey});

  @override
  State<SecondPageScreen> createState() => _SecondPageScreenState();
}

class _SecondPageScreenState extends State<SecondPageScreen> {
  final List<bool> _selectedPhysActivityOption = <bool>[false, true];
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  SurveyContentEnum.genHlth.description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                SurveyContentEnum.genHlth.image,
                height: 30.0,
                width: 30.0,
              )
            ],
          ),
          const SizedBox(height: 16.0),
          SurveyDropDownButton(
              content: SurveyContentEnum.genHlth,
              updateSurvey: widget.updateSurvey)
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  SurveyContentEnum.diffWalk.description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                SurveyContentEnum.diffWalk.image,
                height: 30.0,
                width: 30.0,
                color: Colors.black,
              )
            ],
          ),
          const SizedBox(height: 16.0),
          SurveyBinaryButton(
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
                widget.updateSurvey(SurveyContentEnum.diffWalk, 1);
              } else {
                widget.updateSurvey(SurveyContentEnum.diffWalk, 0);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  SurveyContentEnum.physActivity.description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                SurveyContentEnum.physActivity.image,
                height: 30.0,
                width: 30.0,
              )
            ],
          ),
          const SizedBox(height: 16.0),
          SurveyBinaryButton(
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
                  widget.updateSurvey(SurveyContentEnum.physActivity, 1);
                } else {
                  widget.updateSurvey(SurveyContentEnum.physActivity, 0);
                }
              },
              children: const [Text('Sim'), Text('Não')])
        ],
      ),
    );
  }
}
