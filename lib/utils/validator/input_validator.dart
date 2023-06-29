import './global_validator.dart';

class InputValidator {
  InputValidator({this.error = '', this.steps = const []});
  final String error;
  final List<Function> steps;

  String email(value) {
    final globalValidator = GlobalValidator();
    bool result = globalValidator.email(value);
    String err = error != '' ? error : "This is not email";
    return result ? '' : err;
  }

  String require(value) {
    String err = error != '' ? error : "This field is required";
    return value == '' ? err : '';
  }

  String? stepByStep(dynamic value) {
    dynamic result;
    for (var element in steps) {
      result = element(value);
      if (result != '') break;
    }
    return result == '' ? null : result;
  }
}
