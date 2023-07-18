import 'package:flutter/material.dart';
import 'package:predi_v2/shared/models/enums/survey_content_enum.dart';

class SurveyDropDownButton extends StatefulWidget {
  final SurveyContentEnum content;
  final Function(SurveyContentEnum, dynamic) updateSurvey;
  const SurveyDropDownButton(
      {super.key, required this.content, required this.updateSurvey});

  @override
  State<SurveyDropDownButton> createState() => _SurveyDropDownButtonState();
}

class _SurveyDropDownButtonState extends State<SurveyDropDownButton> {
  late dynamic dropDownValue;

  @override
  void initState() {
    dropDownValue = widget.content.list.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropDownValue,
      isExpanded: true,
      icon: const Icon(Icons.arrow_downward_outlined),
      elevation: 8,
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
      underline: Container(
        height: 2.0,
        color: Theme.of(context).colorScheme.primary,
      ),
      onChanged: (value) {
        setState(() {
          dropDownValue = value!;
          widget.updateSurvey(widget.content, value);
        });
      },
      items: widget.content.list.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
    );
  }
}
