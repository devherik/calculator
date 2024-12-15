class UtilsMath {
  UtilsMath._();
  static final instance = UtilsMath._();

  bool isNumeric(String char) => double.tryParse(char) != null;

  String cleanRightZeros(String value) {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    value = value.replaceAll(regex, '');
    return value;
  }

  bool isNegative(String exp) {
    if (exp[0] == '-' && isNumeric(exp[1])) {
      return true;
    } else {
      return false;
    }
  }

  double toNumeric(String char) {
    if (isNumeric(char)) {
      return double.parse(char);
    } else {
      return 0;
    }
  }
}
