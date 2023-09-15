import 'package:flutter/material.dart';

class SurveyBackButton extends StatefulWidget {
  final PageController pageController;
  final int currentIndex;

  const SurveyBackButton(
      {super.key, required this.pageController, required this.currentIndex});

  @override
  State<SurveyBackButton> createState() => _SurveyBackButtonState();
}

class _SurveyBackButtonState extends State<SurveyBackButton> {
  @override
  Widget build(BuildContext context) {
    return widget.currentIndex > 0
        ? ElevatedButton(
            onPressed: () async {
              if (widget.currentIndex == 1) {
                setState(() {
                  widget.pageController.jumpToPage(0);
                });
              } else if (widget.currentIndex == 2) {
                setState(() {
                  widget.pageController.jumpToPage(1);
                });
              } else if (widget.currentIndex == 3) {
                setState(() {
                  widget.pageController.jumpToPage(2);
                });
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              minimumSize: const Size(328, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text("Voltar",
                style: TextStyle(fontWeight: FontWeight.bold)),
          )
        : const SizedBox.shrink();
  }
}
