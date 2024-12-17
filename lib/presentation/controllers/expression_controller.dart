import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:function_tree/function_tree.dart';

class ExpressionController extends ValueNotifier<String> {
  ExpressionController._(super._value);
  static final instance = ExpressionController._('');

  ValueNotifier result = ValueNotifier<String>('');

  void calculate() {
    try {
      result.value = value.interpret().toStringAsFixed(1);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void updatePartial() {
    try {
      calculate();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void setResult() => value = result.value;

  void clearExpression() => value = '';

  void clearAll() {
    value = '';
    result.value = '';
  }

  /*The methods bellow are the way I created to do the calculation

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
  */
}
