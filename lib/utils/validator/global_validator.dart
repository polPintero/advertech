const Map patterns = {
  'email':
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  'require': r'^.{1}$',
};

class GlobalValidator {
  bool email(value) {
    String pattern = patterns['email'];
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }

  bool require(value) {
    String pattern = patterns['require'];
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }
}
