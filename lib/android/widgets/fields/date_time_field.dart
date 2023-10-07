import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeField extends StatefulWidget {
  final Function(DateTime?) onSavedCallback;

  final FocusNode currentFocus;
  final DateTime? initialValue;

  const DateTimeField(
      {super.key,
      required this.onSavedCallback,
      required this.currentFocus,
      this.initialValue});

  @override
  State<DateTimeField> createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {
  late TextEditingController _dateController;
  late DateTime? _pickedDate;
  late TimeOfDay? _pickedTime;
  late DateTime _pickedDateTime;

  @override
  void initState() {
    _dateController = TextEditingController(
        text: widget.initialValue == null
            ? ''
            : DateFormat('dd-MM-yyyy').format(widget.initialValue!));
    _pickedDate = widget.initialValue ?? DateTime.now();
    _pickedTime = TimeOfDay.now();

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
        onTap: _onTap,
        onSaved: (_) => widget.onSavedCallback(_pickedDateTime),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Por favor digite uma data';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: 'Data e Hora',
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

  _onTap() async {
    _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1923),
        lastDate: DateTime(2033));
    if (_pickedDate != null && context.mounted) {
      _pickedTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (_pickedTime != null) {
        _pickedDateTime = DateTime(_pickedDate!.year, _pickedDate!.month,
            _pickedDate!.day, _pickedTime!.hour, _pickedTime!.minute);
        String formattedDate =
            DateFormat('dd/MM/yyyy - HH:mm').format(_pickedDateTime);

        setState(() {
          _dateController.text = formattedDate;
        });
      }
    }
  }
}
