import 'package:flutter/material.dart';

class ReportInformationAlert extends StatelessWidget {
  final String title;
  final String content;

  const ReportInformationAlert({
    super.key,
    required this.title,
    required this.content,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Relatório',
              style: Theme.of(context).textTheme.headlineSmall!.merge(
                    TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
            ),
            Icon(
              Icons.feed_outlined,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 40.0,
            )
          ],
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(),
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
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.keyboard_return_outlined),
              SizedBox(width: 4.0),
              Text('Voltar', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}
