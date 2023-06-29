import 'package:flutter/material.dart';
import 'package:advertech/components/input.dart';
import 'package:advertech/utils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key, required this.title});

  final String title;
  String btnLabel = 'Send';
  bool isLoading = false;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final formKeyName = GlobalKey<FormState>();
    final formKeyEmail = GlobalKey<FormState>();
    final formKeyMsg = GlobalKey<FormState>();
    bool  isSubmitBtnDisable = true;

    Map<GlobalKey<FormState>, bool> stateInputValidation = {
      formKeyEmail: false,
    };

    void submitBtnDisableSet(){
      isSubmitBtnDisable = stateInputValidation.containsValue(false);
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
                    formKey: formKeyEmail,
                    onChanged: (value) {
                      onChangedHandler(formKeyEmail);
                    }),
                Input(label: 'Email'),
                Input(label: 'Message'),
                ElevatedButton(
                  child: widget.isLoading ? Text('Please wait') : Text('Send'),
                  onPressed: () {
                    // if (widget._formKey.currentState!.validate()) {
                    //   widget.isLoading = true;
                    // }
                    // setState(
                    //   () {},
                    // );
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
