import 'package:flutter/material.dart';
import 'package:predi_v2/android/widgets/buttons/survey_buttons/survey_drop_down_button.dart';

import '../../../shared/models/enums/survey_content_enum.dart';

class ThirdPageScreen extends StatefulWidget {
  final Function(SurveyContentEnum, dynamic) updateSurvey;
  const ThirdPageScreen({super.key, required this.updateSurvey});

  @override
  State<ThirdPageScreen> createState() => _ThirdPageScreenState();
}

class _ThirdPageScreenState extends State<ThirdPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_firstQuestion(), _secondQuestion()],
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
                  SurveyContentEnum.physHlth.description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                SurveyContentEnum.physHlth.image,
                height: 30.0,
                width: 30.0,
              )
            ],
          ),
          SurveyDropDownButton(
              content: SurveyContentEnum.physHlth,
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
                  SurveyContentEnum.education.description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                SurveyContentEnum.education.image,
                height: 30.0,
                width: 30.0,
              )
            ],
          ),
          SurveyDropDownButton(
            content: SurveyContentEnum.education,
            updateSurvey: widget.updateSurvey,
          ),
        ],
      ),
    );
  }
}
