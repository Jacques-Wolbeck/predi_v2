import 'package:flutter/material.dart';

class SimpleAlert extends StatelessWidget {
  final String titleText;
  final String contentText;
  final String button1Text;
  final String button2Text;
  final Function()? onPressed;

  const SimpleAlert({
    super.key,
    required this.titleText,
    required this.contentText,
    required this.button1Text,
    required this.button2Text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        titleText,
        textAlign: TextAlign.center,
        style: const TextStyle(),
      ),
      content: Text(
        contentText,
        textAlign: TextAlign.center,
        style: const TextStyle(),
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            button1Text,
            style: const TextStyle(),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            button2Text,
            style: const TextStyle(),
          ),
        ),
      ],
    );
  }
}
