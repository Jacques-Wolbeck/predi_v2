import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateField extends StatefulWidget {
  final Function(DateTime?) onSavedCallback;
  final FocusNode currentFocus;
  final DateTime? initialValue;

  const DateField(
      {super.key,
      required this.onSavedCallback,
      required this.currentFocus,
      this.initialValue});

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  late TextEditingController _dateController;
  late DateTime? _pickedDate;

  @override
  void initState() {
    _dateController = TextEditingController(
        text: widget.initialValue == null
            ? ''
            : DateFormat('dd-MM-yyyy').format(widget.initialValue!));
    _pickedDate = widget.initialValue ?? DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: _dateController,
        focusNode: widget.currentFocus,
        readOnly: true,
        onTap: () async {
          _pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1923),
              lastDate: DateTime.now());
          if (_pickedDate != null) {
            String formattedDate =
                DateFormat('dd/MM/yyyy').format(_pickedDate!);
            setState(() {
              _dateController.text = formattedDate;
            });
          }
        },
        onSaved: (_) => widget.onSavedCallback(_pickedDate!),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Por favor digite uma data';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: 'Data de nascimento',
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(width: .8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(width: .8),
          ),
          contentPadding: const EdgeInsets.all(16.0),
          prefixIcon: const Icon(Icons.date_range_outlined),
        ),
      ),
    );
  }
}
