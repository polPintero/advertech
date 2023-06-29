import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  Input({this.label = '', this.type = '', this.onChanged, this.formKey});
  final String label;
  final String type;
  final void Function(String)? onChanged;
  final GlobalKey? formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          labelText: label,
          icon: Icon(Icons.lock_open),
        ),
        onChanged: onChanged,
        validator: (String? value) {
          dynamic validationResult = null;
          final processValue = value?.trim();
          if (processValue == null || processValue.isEmpty) {
            validationResult = 'This field is required';
          }
          return validationResult;
        },
      ),
    );
  }
}
