import 'package:flutter/material.dart';

class SimpleAlert extends StatelessWidget {
  final String title;
  final String content;
  final String? button1Text;
  final String button2Text;
  final Function()? onPressed;

  const SimpleAlert({
    super.key,
    required this.title,
    required this.content,
    this.button1Text,
    required this.button2Text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(),
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(),
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      actions: [
        button1Text == null
            ? const SizedBox.shrink()
            : TextButton(
                onPressed: onPressed,
                child: Text(
                  button1Text!,
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
