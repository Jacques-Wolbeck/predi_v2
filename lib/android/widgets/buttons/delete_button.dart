import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/shared/blocs/data/data_event.dart';

import '../../../shared/blocs/authentication/auth_bloc.dart';
import '../../../shared/blocs/authentication/auth_state.dart';
import '../../../shared/blocs/data/data_bloc.dart';
import '../../../shared/models/enums/data_type_enum.dart';

class DeleteButton extends StatefulWidget {
  final List<dynamic> deleteList;
  final VoidCallback onChanged;
  final DataTypeEnum dataType;

  const DeleteButton(
      {super.key,
      required this.deleteList,
      required this.onChanged,
      required this.dataType});

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  @override
  Widget build(BuildContext context) {
    return _buttonContent();
  }

  Widget _buttonContent() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      width: MediaQuery.of(context).size.width * .8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.onSecondary,
              radius: 12,
              child: Text(
                widget.deleteList.length.toString(),
              ),
            ),
          ),
          Text(
            widget.deleteList.length > 1 ? "Selecionados" : "Selecionado",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            onPressed: () async {
              final state = context.read<AuthBloc>().state;
              if (state is Authenticated) {
                context.read<DataBloc>().add(
                      DeleteDataRequested(
                          patient: state.patient,
                          deleteList: widget.deleteList,
                          dataType: widget.dataType),
                    );
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.cancel,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            onPressed: () {
              widget.deleteList.clear();
              widget.onChanged();
            },
          ),
        ],
      ),
    );
  }
}
