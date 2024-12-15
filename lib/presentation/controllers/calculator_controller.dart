import 'package:calculator/utils/utils_math.dart';
import 'package:flutter/foundation.dart';
import 'package:function_tree/function_tree.dart';

class CalculatorController extends ValueNotifier<String> {
  CalculatorController._(super._value);
  static final instance = CalculatorController._('1000');

  final math = UtilsMath.instance;

  ValueNotifier result = ValueNotifier<String>('');
  final List<Map<String, dynamic>> _groups = <Map<String, dynamic>>[];
  int _groupIndex = 0;
  String getValue() => value;
  String getResult() => result.value;

  calculate() {
    try {
      for (var i = 0; i < _groups.length; i++) {
        final String exp = _groups[i]['exp'];
        _groups[i]['result'] = exp.interpret().toStringAsFixed(1);
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      result.value = _groups.last['result'];
    }
  }

  void updatePartial() {
    _groupIndex = 0;
    _groups.clear();
    if (!value.contains('(') && !value.contains(')')) {
      saveGroup(value);
      try {
        calculate();
      } on Exception {
        rethrow;
      }
    } else {
      try {
        orderSentenceGroups(value);
      } on Exception {
        rethrow;
      } finally {
        try {
          calculate();
        } on Exception {
          rethrow;
        }
      }
    }
  }

  bool isAllGroupsClosed() {
    int open = 0, close = 0;
    bool isClosed;
    for (var i = 0; i < value.length; i++) {
      value[i] == '(' ? open++ : null;
      value[i] == ')' ? close++ : null;
    }
    open == close ? isClosed = true : isClosed = false;
    return isClosed;
  }

  String orderSentenceGroups(String exp) {
    if (isAllGroupsClosed()) {
      String group = '', hold = '';
      final int init = exp.indexOf('(');
      // cria uma nova exp a partir do parenteses de abertura
      for (var i = init + 1; i < exp.length; i++) {
        hold += exp[i];
      }
      //chama novamente a funcao caso ache mais parenteses de abertura
      hold.contains('(') ? hold = orderSentenceGroups(hold) : null;
      //salva o grupo e o substitui na exp
      final int end = hold.indexOf(')');
      group = hold.substring(0, end);
      saveGroup(group);
      exp = '${exp.substring(0, init)}g$_groupIndex${hold.substring(end + 1)}';
      !exp.contains(')') ? saveGroup(exp) : null;
      return exp;
    } else {
      throw Exception('Expressão inválida');
    }
  }

  saveGroup(String exp) {
    _groups.add({'group': _groupIndex, 'exp': exp, 'result': 0.0});
    _groupIndex++;
  }
}
