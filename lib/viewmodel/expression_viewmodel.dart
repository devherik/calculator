import 'dart:developer';

import 'package:calculator/model/expression_entity.dart';
import 'package:calculator/repositories_services/localstorage_repository.dart';
import 'package:calculator/repositories_services/localstorage_repository_imp.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

class ExpressionViewmodel extends ValueNotifier<String> {
  ExpressionViewmodel._(super._value);
  static final instance = ExpressionViewmodel._('');

  final total = ValueNotifier<String>('');
  final LocalstorageRepository _localstorage =
      LocalstorageRepositoryImp.instance;

  bool status = false;

  final history = ValueNotifier<List<ExpressionEntity>>(<ExpressionEntity>[]);

  void init() {
    if (!status) {
      updateHistory();
      status = true;
    }
  }

  void end() => status = false;

  Result<bool> calculate() {
    try {
      return const Success(true);
    } on Exception {
      return Failure(Exception());
    }
  }

  void updatePartialResult() =>
      calculate().onFailure((failure) => log(failure.toString()));

  void updateHistory() {
    _localstorage.getCollection('calculator').onSuccess((success) {
      for (var element in success) {
        history.value.add(ExpressionEntity.fromJson(element));
      }
    }).onFailure((failure) => log(failure.toString()));
  }

  void persistResult() {
    final calc = ExpressionEntity(sentence: value, result: total.value);
    _localstorage.persist('calculator', calc.toJson()).onSuccess((success) {
      updateHistory();
      value = total.value;
      total.value = '';
    }).onFailure((failure) => log(failure.toString()));
  }

  void clearExpression() => value = '';

  void clearHistory() {
    _localstorage
        .clearBox('calculator')
        .onSuccess((success) => history.value = <ExpressionEntity>[])
        .onFailure((failure) => log(failure.toString()));
  }

  void clearAll() {
    value = '';
    total.value = '';
  }
}
