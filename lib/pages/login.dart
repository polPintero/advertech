import 'package:flutter/material.dart';
import 'package:advertech/components/input.dart';

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

    void onChangedHandler(formKey) {
      stateInputValidation[formKey] = formKey.currentState!.validate();
      submitBtnDisableSet();
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
                  formKey: formKeyName,
                  onChanged: (value) {
                    onChangedHandler(formKeyName);
                  },
                ),
                Input(
                  label: 'Email',
                  formKey: formKeyEmail,
                  onChanged: (value) {
                    onChangedHandler(formKeyEmail);
                  },
                ),
                Input(
                  label: 'Message',
                  formKey: formKeyMsg,
                  onChanged: (value) {
                    onChangedHandler(formKeyMsg);
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
