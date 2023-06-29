import 'package:flutter/material.dart';
import 'package:advertech/components/input.dart';
import 'package:advertech/utils/validator/input_validator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key, required this.title});

  final String title;
  String btnLabel = 'Send';
  bool isLoading = false;
  bool isSubmitBtnDisable = true;

  Map<String, String> formData = {'name': '', 'email': '', 'message': ''};

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailValidator =
      InputValidator(steps: [InputValidator().require, InputValidator().email]);
  final requireValidator =
      InputValidator(steps: [InputValidator().require]);
  @override
  Widget build(BuildContext context) {
    final formKeyName = GlobalKey<FormState>();
    final formKeyEmail = GlobalKey<FormState>();
    final formKeyMsg = GlobalKey<FormState>();

    Map<GlobalKey<FormState>, bool> stateInputValidation = {
      formKeyName: false,
      formKeyEmail: false,
      formKeyMsg: false,
    };

    void submitBtnDisableSet() {
      widget.isSubmitBtnDisable = stateInputValidation.containsValue(false);
      if (!widget.isSubmitBtnDisable) {
        setState(() {});
      }
    }

    void onFocusChangeHandler(
        FocusNode? focusNode, GlobalKey<FormState>? formKey) {
      if (focusNode == null || formKey == null) return;
      if (!focusNode.hasFocus) {
        stateInputValidation[formKey] = formKey.currentState!.validate();
        submitBtnDisableSet();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            // key: widget._formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Input(
                  label: 'Name',
                  defaultValue: widget.formData['name'].toString(),
                  formKey: formKeyName,
                  onFocusChange: onFocusChangeHandler,
                  validator: requireValidator.stepByStep,
                  onChanged: (value) {
                    widget.formData['name'] = value;
                  },
                ),
                Input(
                  label: 'Email',
                  defaultValue: widget.formData['email'].toString(),
                  formKey: formKeyEmail,
                  onFocusChange: onFocusChangeHandler,
                  validator: emailValidator.stepByStep,
                  onChanged: (value) {
                    widget.formData['email'] = value;
                  },
                ),
                Input(
                  label: 'Message',
                  defaultValue: widget.formData['message'].toString(),
                  formKey: formKeyMsg,
                  onFocusChange: onFocusChangeHandler,
                  validator: requireValidator.stepByStep,
                  onChanged: (value) {
                    widget.formData['message'] = value;
                  },
                ),
                ElevatedButton(
                  child: widget.isLoading ? Text('Please wait') : Text('Send'),
                  onPressed: widget.isSubmitBtnDisable
                      ? null
                      : () {
                          widget.isLoading = true;
                          setState(
                            () {},
                          );
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
