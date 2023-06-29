import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  Input({
    this.label = '',
    this.type = '',
    this.onChanged,
    this.formKey,
    this.defaultValue = '',
    this.focusNode,
    this.onFocusChange,
  });
  final String label;
  final String type;
  final void Function(String)? onChanged;
  final GlobalKey<FormState>? formKey;
  final String defaultValue;
  final FocusNode? focusNode;
  final void Function(FocusNode?, GlobalKey<FormState>?)? onFocusChange;

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    if(onFocusChange != null){
    focusNode.addListener(() {
      onFocusChange?.call(focusNode,formKey);
    });
    }

    return Form(
      key: formKey,
      child: TextFormField(
        focusNode: onFocusChange != null ? focusNode : null,
        controller: TextEditingController(text: defaultValue),
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
