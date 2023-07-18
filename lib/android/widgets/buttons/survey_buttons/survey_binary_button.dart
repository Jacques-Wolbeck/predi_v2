import 'package:flutter/material.dart';

class SurveyBinaryButton extends StatefulWidget {
  final List<bool> selectedOption;
  final Function(int)? onPressed;
  final List<Widget> children;
  const SurveyBinaryButton(
      {super.key,
      required this.selectedOption,
      required this.onPressed,
      required this.children});

  @override
  State<SurveyBinaryButton> createState() => _SurveyBinaryButtonState();
}

class _SurveyBinaryButtonState extends State<SurveyBinaryButton> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ToggleButtons(
        direction: Axis.horizontal,
        onPressed: widget.onPressed,
        borderRadius: BorderRadius.circular(8.0),
        selectedBorderColor: Theme.of(context).colorScheme.secondaryContainer,
        selectedColor: Theme.of(context).colorScheme.onSecondary,
        fillColor: Theme.of(context).colorScheme.secondary,
        constraints: const BoxConstraints(minHeight: 40.0, minWidth: 80.0),
        isSelected: widget.selectedOption,
        children: widget.children,
      ),
    );
  }
}
