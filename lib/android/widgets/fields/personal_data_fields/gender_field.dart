import 'package:flutter/material.dart';

enum GenderOptons { masculino, feminino }

class GenderField extends StatefulWidget {
  final Function(String) onSaveCallback;

  const GenderField({super.key, required this.onSaveCallback});

  @override
  State<GenderField> createState() => _GenderFieldState();
}

class _GenderFieldState extends State<GenderField> {
  GenderOptons? _gender = GenderOptons.masculino;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            const Text('Gênero', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile(
              title: const Text('Masculino'),
              groupValue: _gender,
              onChanged: (GenderOptons? value) {
                setState(() {
                  _gender = value;
                  widget.onSaveCallback('Masculino');
                });
              },
              value: GenderOptons.masculino,
            ),
            RadioListTile(
              title: const Text('Feminino'),
              groupValue: _gender,
              onChanged: (GenderOptons? value) {
                setState(() {
                  _gender = value;
                  widget.onSaveCallback('Feminino');
                });
              },
              value: GenderOptons.feminino,
            ),
          ],
        ));
  }
}
