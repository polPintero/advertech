import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  Input({
    this.label = '',
    this.type = '',
  });
  final String label;
  final String type;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 24.0),
      decoration: InputDecoration(
        labelText: label,
        icon: Icon(Icons.lock_open),
      ),
      validator: (String? value) {
        dynamic validationResult = null;
        final processValue = value?.trim();
        if (processValue == null || processValue.isEmpty) {
          validationResult = 'This field is required';
        }

        return validationResult;


      },
    );
  }
}
