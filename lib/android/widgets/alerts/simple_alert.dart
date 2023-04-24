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
      iconPadding: EdgeInsets.zero,
      icon: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall!.merge(
                TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
        ),
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
            : ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_outlined),
                    const SizedBox(width: 4.0),
                    Text(button1Text!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.keyboard_return_outlined),
              const SizedBox(width: 4.0),
              Text(button2Text,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}
