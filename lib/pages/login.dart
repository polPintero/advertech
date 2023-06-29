import 'package:flutter/material.dart';
import 'package:advertech/components/input.dart';
import 'package:advertech/utils/validator/input_validator.dart';
import 'package:advertech/utils/api.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  bool isLoading = false;
  bool isSubmitBtnDisable = true;

  Map<String, String> formData = {'name': '', 'email': '', 'message': ''};

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    String labelBtn = widget.isLoading ? 'Please wait' : 'Send';
    double gap = 20.0;
    final emailValidator = InputValidator(
        steps: [InputValidator().require, InputValidator().email]);
    final requireValidator = InputValidator(steps: [InputValidator().require]);

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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
        child: ListView(
          children: [
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text('Contact us',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
                  SizedBox(height: gap * 2),
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
                  SizedBox(height: gap),
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
                  SizedBox(height: gap),
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
                  SizedBox(height: gap * 3),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Colors.purple.shade200),
                      ),
                      onPressed: widget.isSubmitBtnDisable
                          ? null
                          : () async {
                              widget.isLoading = true;
                              setState(() {});
                               await api.sendLoginData(
                                  widget.formData, context);
                             
                            },
                      child: Padding(
                        padding: EdgeInsets.all(gap),
                        child: Text(
                          labelBtn,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
